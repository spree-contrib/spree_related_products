Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_related_products'
  s.version     = '3.2'
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

  s.add_dependency 'spree_core', '>= 1.0.0.rc3'

  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'rspec-rails',  ' ~> 2.8.0.rc1'
  s.add_development_dependency 'sqlite3'
end
