require 'url_extractor'

describe UrlExtractor::PlainText do

  it 'returns a string with the modified URLs that were returned in the block' do
    extractor = UrlExtractor::PlainText.new
    text = 'foo bar http://google.com'

    actual = extractor.replace_urls(text) do |extracted|
      'http://foo.bar'
    end

    actual.should == 'foo bar http://foo.bar'
  end

  it 'ignores urls that match patterns provided' do
    extractor = UrlExtractor::PlainText.new([/google/])
    text = 'http://google.com http://foobar.com'

    actual = extractor.replace_urls(text) do |extracted|
      'http://foo.bar'
    end

    actual.should == 'http://google.com http://foo.bar'
  end

  it "ignores URLs that don't match http or https" do
    extractor = UrlExtractor::PlainText.new
    text = "Reminder: Blah"

    actual = extractor.replace_urls(text) do |extracted|
      'http://foo.bar'
    end

    actual.should == 'Reminder: Blah'
  end

end
