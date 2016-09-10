require 'net/http'
require 'nokogiri'

namespace :fetch do
  task all: %i(legislators bills votes)

  task :legislators do
    puts "Deleting legislators..."
    Legislator.delete_all

    puts "Fetching legislators..."
    SunlightClient.get(:legislators)
      .each { |l| Legislator.create(Legislator.scrub_params(l)) }
  end

  task bills: %i(bills:destroy bills:seed bills:related)

  MISSING_LEGISLATORS = ['B000589']

  namespace :bills do
    task :seed do
      puts "Fetching bills..."
      SunlightClient.get(:bills, congress: 114, chamber: 'house', per_page: 50, last_page: 20)
        .map { |bill| bill.tap { |b| b['pdf'] = b['last_version'].to_h['urls'].to_h['pdf'] } }
        .each { |b| Bill.create(Bill.scrub_params(b)) }
    end

    task :related do
      loop do
        related_bills = SunlightClient.get(:bills, bill_id__in: get_related_bill_ids.join('|'))
        break if related_bills.reject { |b| MISSING_LEGISLATORS.include?(b['sponsor_id']) }.empty?

        puts "Fetching related bills (#{related_bills.count})..."

        bills_params = related_bills.map do |bill|
          bill['pdf'] = bill['last_version'].to_h['urls'].to_h['pdf']
          Bill.scrub_params(bill)
        end

        Bill.create(bills_params)
      end
    end

    task :destroy do
      puts "Deleting bills..."
      Bill.delete_all
    end
  end

  task votes: %i(votes:destroy votes:related)

  namespace :votes do
    task :related do
      queue = Queue.new
      vote_rolls = []

      puts "Fetching votes..."
      Bill.all.pluck(:bill_id).each_slice(100) do |bill_ids|
        votes = SunlightClient.get(:votes, chamber: 'house', bill_id__in: bill_ids.join('|'))
        queue.push votes
      end

      workers = (0..8).map do
        Thread.new do
          begin
            while votes = queue.pop(true)
              votes.each do |vote|
                puts "Fetching roll #{vote['roll_id']}: #{vote['url']}..."
                roll = Nokogiri::HTML(Net::HTTP.get(URI(vote['url'])))
                vote_rolls << [vote, roll]
              end
            end
          rescue ThreadError
          end
        end
      end
      workers.map(&:join)

      puts "Creating votes"
      vote_rolls.each { |v, r| v['summary'] = collect_vote_summary(r) }
      Vote.create(vote_rolls.map { |v, _| Vote.scrub_params(v) })

      puts "Collecting votes"
      headers = %i(legislator_id roll_id vote_cast)
      cast_votes = []
      vote_rolls.each do |vote, roll|
        recorded_vote = roll.search('recorded-vote').children.each_slice(2).to_a
        recorded_vote.each do |legislator_hash, cast_vote|
          next if missing_legislators(recorded_vote).include?(legislator_hash['name-id'])
          cast_votes << [legislator_hash['name-id'], vote['roll_id'], cast_vote.content]
        end
      end

      puts "Casting votes"
      CastVote.transaction do
        CastVote.import(headers, cast_votes, validate: false)
      end
    end

    task :destroy do
      puts "Deleting votes..."
      Vote.delete_all
    end
  end
end

def collect_vote_summary(roll)
  yeas = roll.search('yea-total')
  nays = roll.search('nay-total')

  {
    r_yeas: yeas[0].children[0].text.to_i,
    r_nays: nays[0].children[0].text.to_i,
    d_yeas: yeas[1].children[0].text.to_i,
    d_nays: nays[1].children[0].text.to_i,
    i_yeas: yeas[2].children[0].text.to_i,
    i_nays: nays[2].children[0].text.to_i,
    yeas_total: yeas[3].children[0].text.to_i,
    nays_total: nays[3].children[0].text.to_i,
  }
end

def get_related_bill_ids
  Bill.all.pluck(:related_bill_ids).flatten.uniq - Bill.all.pluck(:bill_id)
end

def missing_legislators(recorded_vote)
  recorded_vote.map { |l, _| l['name-id'] } - legislator.all.pluck(:bioguide_id)
end
