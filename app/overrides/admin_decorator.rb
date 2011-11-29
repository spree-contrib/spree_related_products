Deface::Override.new(:virtual_path => "spree/admin/shared/_product_tabs",
                     :name => "add_related_products_tab",
                     :insert_bottom => "[data-hook='admin_product_tabs']",
                     :partial => "spree/admin/products/related_products",
                     :disabled => false)

Deface::Override.new(:virtual_path => "spree/admin/configurations/index",
                     :name => "add_configuration_line",
                     :insert_bottom => "[data-hook='admin_configurations_menu']",
                     :text => "<%= configurations_menu_item(I18n.t('relation_types'), admin_relation_types_url, I18n.t('manage_relation_types')) %>",
                     :disabled => false)
