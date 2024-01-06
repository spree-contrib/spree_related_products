# frozen_string_literal: true

module Spree::Admin::SpreeRelatedProducts::ProductsControllerDecorator
  def related
    load_resource
    @relation_types = Spree::Product.relation_types
  end
end

Spree::Admin::ProductsController.prepend(Spree::Admin::SpreeRelatedProducts::ProductsControllerDecorator)
