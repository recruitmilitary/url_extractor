module UrlExtractor
  module Util

    extend self

    NON_WHITESPACE_REGEXP = %r![^\s#{[0x3000].pack("U")}]!

    def blank_string?(string)
      string !~ NON_WHITESPACE_REGEXP
    end

  end
end
