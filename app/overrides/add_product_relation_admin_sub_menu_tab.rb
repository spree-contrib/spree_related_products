Deface::Override.new(
  virtual_path: 'spree/admin/shared/sub_menu/_product',
  name: 'add_product_relation_admin_sub_menu_tab',
  insert_bottom: '[data-hook="admin_product_sub_tabs"]',
  text: '<%= tab :relation_types, label: Spree::RelationType.model_name.human(count: :many) %>',
  disabled: false
)
