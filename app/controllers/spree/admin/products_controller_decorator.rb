Spree::Admin::ProductsController.class_eval do
  def related
    load_resource
    @relation_types = Spree::Product.relation_types
  end
end
