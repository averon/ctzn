namespace :fetch do
  task all: %i(votes legislators bills)

  task :votes do
    puts "Deleting votes..."
    Vote.delete_all
    puts "Fetching votes..."
    SunlightClient.get(:votes)
      .select { |v| v['chamber'] == 'house' }
      .each { |v| Vote.create(Vote.scrub_params(v)) }
  end

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
end
