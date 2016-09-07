require 'net/http'

class SunlightClient

  API_KEY = "ffc9a6f15c2940399e13d04651a8b999"
  BASE_URL = "http://congress.api.sunlightfoundation.com"

  def self.get(keyword)
    raise ArgumentError unless %i(legislators bills votes).include?(keyword)

    first_page, last_page = get_page_range(keyword)

    collection = (first_page.to_i).upto(last_page.to_i).inject([]) do |collection, page|
      print '.'
      data = get_content("#{url_for(keyword)}&page=#{page}")
      collection += data['results']
    end
  end

  def self.get_first(keyword, options={})
    raise ArgumentError unless %i(legislators bills votes).include?(keyword)
    url = URI(url_for(keyword))
    url.query = URI.encode_www_form(options.merge(apikey: API_KEY))
    get_content(url)["results"].first
  end

  def self.get_page_range(keyword)
    metadata = get_content(url_for(keyword))
    [metadata['page']['page'], metadata['page']['count']]
  end

  def self.get_content(url)
    JSON.parse(Net::HTTP.get(URI(url)))
  end

  def self.url_for(keyword)
    "#{BASE_URL}/#{keyword}?apikey=#{API_KEY}"
  end
end
