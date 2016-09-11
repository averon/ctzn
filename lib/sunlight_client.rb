require 'net/http'

class SunlightClient

  API_KEY = "ffc9a6f15c2940399e13d04651a8b999"
  BASE_URL = "http://congress.api.sunlightfoundation.com"
  VALID_KEYWORDS = %i(legislators legislators/locate committees bills amendments votes)

  def self.get(keyword, options={})
    raise ArgumentError unless VALID_KEYWORDS.include?(keyword)

    first_page = options.fetch(:page) { 1 }
    last_page =  options.delete(:last_page) { page_count(keyword, options) }

    collection = (first_page).upto(last_page).inject([]) do |collection, page|
      print page
      data = get_content(url_for(keyword, options.merge(page: page)))
      puts data
      collection += data['results']
    end
  end

  def self.get_first(keyword, options={})
    raise ArgumentError unless VALID_KEYWORDS.include?(keyword)
    url = url_for(keyword, options)
    get_content(url)["results"].first
  end

  def self.page_count(keyword, options)
    metadata = get_content(url_for(keyword, options))
    pages = metadata.fetch('count') { 0 } / metadata['page'].to_h.fetch('per_page') { 1 }

    if metadata['error']
      0
    elsif pages.zero?
      1
    else
      pages
    end
  end

  def self.get_content(url)
    JSON.parse(Net::HTTP.get(URI(url)))
  end

  def self.url_for(keyword, options={})
    options.merge!(apikey: API_KEY)

    url = URI("#{BASE_URL}/#{keyword}")
    url.query = URI.encode_www_form(options)
    puts url
    url
  end
end
