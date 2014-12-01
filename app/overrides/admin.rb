Deface::Override.new(:virtual_path => "spree/admin/shared/_product_tabs",
                     :name => "add_related_products_tab",
                     :insert_bottom => "[data-hook='admin_product_tabs']",
                     :partial => "spree/admin/products/related_products",
                     :disabled => false)

Deface::Override.new(:virtual_path => "spree/admin/shared/_configuration_menu",
                     :name => "add_configuration_line",
                     :insert_bottom => "[data-hook='admin_configurations_sidebar_menu'], #admin_configurations_sidebar_menu[data-hook]",
                     :text => "<%= configurations_sidebar_menu_item(Spree.t('manage_relation_types'), admin_relation_types_url) %>",
                     :disabled => false)
