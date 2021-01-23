module SpreeRelatedProducts
  module_function

  # Returns the version of the currently loaded SpreeRelatedProducts as a
  # <tt>Gem::Version</tt>.
  def version
    Gem::Version.new VERSION::STRING
  end

  module VERSION
    MAJOR = 3
    MINOR = 4
    TINY  = 0

    STRING = [MAJOR, MINOR, TINY].compact.join('.')
  end
end
