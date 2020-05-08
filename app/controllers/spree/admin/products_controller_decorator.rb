module Spree::Admin::ProductsControllerDecorator
  def related
    load_resource
    @relation_types = Spree::Product.relation_types
  end
end

Spree::Admin::ProductsController.prepend(Spree::Admin::ProductsControllerDecorator)
