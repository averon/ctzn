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

  task :bills do
    puts "Deleting bills..."
    Bill.delete_all

    puts "Fetching bills..."
    SunlightClient.get(:bills)
      .map { |hash| hash.tap { |h| h['pdf'] = h['last_version']['urls']['pdf'] } }
      .each { |b| Bill.create(Bill.scrub_params(b)) }
  end

  task :votes do
    puts "Deleting votes..."
    Vote.delete_all

    puts "Fetching votes..."
    votes = SunlightClient.get(:votes).select { |v| v['chamber'] == 'house' }

    votes.each do |vote|
      puts "Fetching roll #{vote['roll_id']}..."
      roll = Nokogiri::HTML(Net::HTTP.get(URI(vote['url'])))

      create_vote!(vote, roll)
      cast_votes!(vote, roll)
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

def create_vote!(vote, roll)
  puts "Creating vote..."
  vote['summary'] = collect_vote_summary(roll)
  Vote.create(Vote.scrub_params(vote))
end

def cast_votes!(vote, roll)
  legislators = Legislator.all
  recorded_vote = roll.search('recorded-vote').children.each_slice(2).to_a

  puts "Applying cast votes..."
  recorded_vote.each do |legislator_hash, cast_vote|
    if legislator = legislators.find_by_bioguide_id(legislator_hash['name-id'])
      puts " #{legislator.first_name} #{legislator.last_name} cast vote #{cast_vote.content}"
      legislator.cast_votes.create(roll_id: vote['roll_id'], vote_cast: cast_vote.content)
    else
      puts "! Couldn't find legislator with bioguide_id #{legislator_hash['name-id']}"
    end
  end
end
