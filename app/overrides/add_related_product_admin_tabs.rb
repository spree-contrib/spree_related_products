Deface::Override.new(
  virtual_path: 'spree/admin/shared/_product_tabs',
  name: 'add_related_products_admin_tab',
  insert_bottom: '[data-hook="admin_product_tabs"]',
  partial: 'spree/admin/products/related_products',
  original: 'c4791d35732b95bae11a32d2f9b6d0e6155f1fea'
)
