require 'spree_core'

module SpreeRelatedProducts
  class Engine < Rails::Engine
    engine_name 'spree_related_products'

    def self.activate

      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      # Calculator::RelatedProductDiscount.register
    end

    config.autoload_paths += %W(#{config.root}/lib #{config.root}/app/models/spree/calculator)
    config.to_prepare &method(:activate).to_proc

  end
end

