module SpreeRelatedProducts
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option :migrate, type: :boolean, default: true, banner: 'Migrate the database'

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_related_products'
      end

      def run_migrations
        if options[:migrate]
          run 'bundle exec rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end
    end
  end
end
