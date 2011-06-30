Admin::ProductsController.class_eval do
  def related
    load_resource
    @relation_types = Product.relation_types
  end
end
