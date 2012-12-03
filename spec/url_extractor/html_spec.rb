require 'url_extractor'

describe UrlExtractor::HTML do
  def html_wrapped_string(string)
    "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">\n<html><body>#{string}\n</body></html>\n"
  end

  it 'returns a string with the modified URLs that were returned in the block' do
    extractor = UrlExtractor::HTML.new
    text = html_wrapped_string('foo bar <a href="http://google.com">Google</a>')

    actual = extractor.replace_urls(text) do |extracted|
      'http://foo.bar'
    end

    actual.should == html_wrapped_string("foo bar <a href=\"http://foo.bar\">Google</a>")
  end

  it 'ignores urls that match patterns provided' do
    extractor = UrlExtractor::HTML.new([/google/])
    text = html_wrapped_string('foo bar <a href="http://google.com">Stuff</a> <a href="http://bar.baz">Google</a>')

    actual = extractor.replace_urls(text) do |extracted|
      'http://foo.bar'
    end

    actual.should == html_wrapped_string("foo bar <a href=\"http://google.com\">Stuff</a> <a href=\"http://foo.bar\">Google</a>")
  end

  it "ignores URLs that don't match http or https" do
    extractor = UrlExtractor::HTML.new
    text = html_wrapped_string("foo bar <a href=\"Reminder:foobar\">Hi</a>")

    actual = extractor.replace_urls(text) do |extracted|
      'http://foo.bar'
    end

    actual.should == text
  end

end
