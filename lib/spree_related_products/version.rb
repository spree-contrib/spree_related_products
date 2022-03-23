module SpreeRelatedProducts
  VERSION = '3.4.2'.freeze

  module_function

  # Returns the version of the currently loaded SpreeRelatedProducts as a
  # <tt>Gem::Version</tt>.
  def version
    Gem::Version.new VERSION
  end
end
