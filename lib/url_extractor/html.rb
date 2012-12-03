require 'nokogiri'

module UrlExtractor
  class HTML

    InvalidURL = Class.new(StandardError)

    def initialize(ignore_patterns = [])
      @ignore_patterns = ignore_patterns
    end

    def replace_urls(template)
      document = Nokogiri::HTML(template)

      document.search("a").each do |link|
        url = link['href']
        raise InvalidURL, "cannot be blank" if UrlExtractor::Util.blank_string?(url)
        next if ignored_url?(url)

        link['href'] = yield(url)
      end

      document.to_s
    end

    private

    def ignored_url?(url)
      url !~ /https?:\/\// || @ignore_patterns.any? { |pattern| url =~ pattern }
    end

  end
end
