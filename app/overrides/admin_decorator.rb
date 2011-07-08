Deface::Override.new(:virtual_path => "admin/shared/_product_tabs",
                     :name => "addd_related_products_tab",
                     :insert_bottom => "[data-hook='admin_product_tabs']",
                     :partial => "admin/products/related_products",
                     :disabled => false)

Deface::Override.new(:virtual_path => "admin/configurations/index",
                     :name => "add_configuration_line",
                     :insert_bottom => "[data-hook='admin_configurations_menu']",
                     :text => "<%= configurations_menu_item(I18n.t('relation_types'), admin_relation_types_url, I18n.t('manage_relation_types')) %>",
                     :disabled => false)
