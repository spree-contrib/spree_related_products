insert_after_selector =
  if defined?(Deface::LambdaMatcher)
    Deface::LambdaMatcher.new do |document|
      [document.xpath(".//erb").last]
    end
  else
    ':last-child' # TODO: this doesn't work correctly
  end
Deface::Override.new(
  virtual_path: 'spree/admin/shared/_product_tabs',
  name: 'add_related_products_admin_tab',
  insert_after: insert_after_selector,
  partial: 'spree/admin/products/related_products'
)
