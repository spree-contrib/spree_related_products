Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_related_products'
  s.version     = '4.0' #NOTE: Version is arbitrary since intended only for use with bundler and specific SHA
  s.summary     = 'Allows multiple types of relationships between products to be defined'
  s.description = 'Allows multiple types of relationships between products to be defined'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'Brian Quinn'
  s.email             = 'brian@railsdog.com'
  s.homepage          = 'http://spreecommerce.com'
  s.rubyforge_project = 'spree_related_products'

  s.files        = Dir['README.md', 'lib/**/*', 'app/**/*', 'config/*']
  s.require_path = 'lib'
  s.requirements << 'none'

  s.has_rdoc = true

  s.add_dependency('spree_core')
  s.add_dependency('spree_promo')
end
