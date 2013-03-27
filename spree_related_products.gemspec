Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_related_products'
  s.version     = '3.2'
  s.summary     = 'Allows multiple types of relationships between products to be defined'
  s.description = 'Allows multiple types of relationships between products to be defined'
  s.required_ruby_version = '>= 1.9.3'

  s.author            = 'Brian Quinn'
  s.email             = 'brian@railsdog.com'
  s.homepage          = 'http://spreecommerce.com'
  s.rubyforge_project = 'spree_related_products'

  s.files        = Dir['README.md', 'lib/**/*', 'app/**/*', 'config/*']
  s.require_path = 'lib'
  s.requirements << 'none'

  s.has_rdoc = true

  s.add_dependency 'spree_core', '~> 2.0.0.beta'

  s.add_development_dependency 'factory_girl', '2.6.4'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.9.0'
  s.add_development_dependency 'sqlite3'
end
