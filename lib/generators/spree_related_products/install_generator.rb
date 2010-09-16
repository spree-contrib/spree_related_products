module SpreeRelatedProducts
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Configures your Rails application for use with spree_related_products"

      def copy_migrations
        directory "db"
      end

    end
  end
end

