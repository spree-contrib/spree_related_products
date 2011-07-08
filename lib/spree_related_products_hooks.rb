class SpreeRelatedProductsHooks < Spree::ThemeSupport::HookListener

  insert_after :admin_product_tabs, "admin/products/related_products"

  insert_after :admin_configurations_menu do
    "<%= configurations_menu_item(I18n.t('relation_types'), admin_relation_types_url, I18n.t('manage_relation_types')) %>"
  end

end