Admin::ProductsController.class_eval do
  def related
    load_object
    @relation_types = Product.relation_types
  end
end