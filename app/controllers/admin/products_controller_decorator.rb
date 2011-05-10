Admin::ProductsController.class_eval do
  def related
    @relation_types = Product.relation_types
  end
end