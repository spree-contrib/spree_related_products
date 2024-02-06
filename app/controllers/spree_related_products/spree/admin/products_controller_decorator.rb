module SpreeRelatedProducts
  module Spree
    module Admin
      module ProductsControllerDecorator
        def related
          load_resource
          @relation_types = ::Spree::Product.relation_types
        end
      end
    end
  end
end

::Spree::Admin::ProductsController.prepend(::SpreeRelatedProducts::Spree::Admin::ProductsControllerDecorator)
