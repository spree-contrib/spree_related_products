module SpreeRelatedProducts
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_related_products'

    config.autoload_paths += %W(#{config.root}/lib #{config.root}/app/models/spree/calculator)

    initializer 'spree.promo.register.promotion.calculators' do |app|
      app.config.spree.calculators.promotion_actions_create_adjustments << Spree::Calculator::RelatedProductDiscount
    end

    class << self
      def activate
        cache_klasses = %W(#{config.root}/app/**/*_decorator*.rb #{config.root}/app/overrides/*.rb)
        Dir.glob(cache_klasses) do |klass|
          Rails.configuration.cache_classes ? require(klass) : load(klass)
        end
      end
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
