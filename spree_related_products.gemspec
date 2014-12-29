Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_related_products'
  s.version     = '3.2'
  s.summary     = 'Allows multiple types of relationships between products to be defined'
  s.description = s.summary
  s.required_ruby_version = '>= 1.9.3'

  s.author            = 'Brian Quinn'
  s.email             = 'brian@railsdog.com'
  s.homepage          = 'http://spreecommerce.com'
  s.rubyforge_project = 'spree_related_products'
  s.license           = %q{BSD-3}

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.has_rdoc = true

  s.add_dependency 'spree_backend', '~> 2.4.0'

  s.add_development_dependency 'factory_girl', '4.4'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails', '~> 2.14'
  s.add_development_dependency 'sqlite3', '~> 1.3.8'
  s.add_development_dependency 'capybara', '~> 2.2.1'
  s.add_development_dependency 'poltergeist', '~> 1.5.0'
  s.add_development_dependency 'shoulda-matchers', '~> 2.5'
  s.add_development_dependency 'simplecov', '~> 0.7.1'
  s.add_development_dependency 'database_cleaner', '~> 1.2.0'
  s.add_development_dependency 'coffee-rails', '~> 4.0.0'
  s.add_development_dependency 'sass-rails', '~> 4.0.0'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'pry-rails'
end
