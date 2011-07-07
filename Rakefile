require 'rubygems'
require 'rake'

require 'bundler'
Bundler::GemHelper.install_tasks
Bundler.setup

require 'rspec'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

desc "Default Task"
task :default => [:spec]

desc "Default Task"
task :default => [ :spec ]

desc "Regenerates a rails 3 app for testing"
task :test_app do
  require 'spree'
  require 'generators/spree/test_app_generator'
  class StoreTestAppGenerator < Spree::Generators::TestAppGenerator

    def install_gems
      inside "test_app" do
        run 'rake spree_core:install'
        run 'rake spree_related_products:install'
      end
    end

    def migrate_db
      run_migrations
    end

    protected
    def full_path_for_local_gems
      <<-gems
gem 'spree_core'
gem 'spree_related_products', :path => \'#{File.dirname(__FILE__)}\'
      gems
    end

  end
  StoreTestAppGenerator.start
end

namespace :test_app do
  desc 'Rebuild test and cucumber databases'
  task :rebuild_dbs do
    system("cd spec/test_app && rake db:drop db:migrate RAILS_ENV=test")
  end
end
