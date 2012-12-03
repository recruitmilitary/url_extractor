require 'uri'

module UrlExtractor
  class PlainText

    def initialize(ignore_patterns = [])
      @ignore_patterns = ignore_patterns
    end

    def replace_urls(text)
      urls = URI.extract text

      urls.each do |url|
        next if ignogred_url?(url)

        text = text.gsub url, yield(url)
      end

      text
    end

    private

    def ignogred_url?(url)
      url !~ /https?:\/\// || @ignore_patterns.any? { |pattern| url =~ pattern }
    end

  end
end
