lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'spree_related_products/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_related_products'
  s.version     = SpreeRelatedProducts.version
  s.summary     = 'Allows multiple types of relationships between products to be defined'
  s.description = s.summary
  s.required_ruby_version = '>= 2.2.7'

  s.author       = 'Brian Quinn'
  s.email        = 'brian@railsdog.com'
  s.homepage     = 'https://github.com/spree-contrib/spree_related_products'
  s.license      = 'BSD-3'

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  spree_version =  ">= #{s.version}"
  s.add_runtime_dependency 'spree_core', spree_version
  s.add_runtime_dependency 'spree_backend', spree_version
  s.add_runtime_dependency 'spree_api_v1', spree_version
  s.add_runtime_dependency 'spree_extension'
  s.add_runtime_dependency 'deface', '~> 1.0'

  s.add_development_dependency 'spree_dev_tools'
  s.add_development_dependency 'shoulda-matchers'
end
