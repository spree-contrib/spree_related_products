Rails.application.config.after_initialize do
  if Spree::Core::Engine.backend_available?
    Rails.application.config.spree_backend.tabs[:product].add(
      ::Spree::Admin::Tabs::TabBuilder.new(Spree.t(:related_products), ->(resource) { ::Spree::Core::Engine.routes.url_helpers.related_admin_product_path(resource) }).
        with_icon_key('resize-small').
        with_active_check.
        with_manage_ability_check(::Spree::Relation).
        build
    )

    Rails.application.config.spree_backend.main_menu.add_to_section('products',
      ::Spree::Admin::MainMenu::ItemBuilder.new('relation_types', ::Spree::Core::Engine.routes.url_helpers.admin_relation_types_path).
        with_manage_ability_check(::Spree::RelationType).
        with_match_path('/relation_types').
        build
    )
  end
end
