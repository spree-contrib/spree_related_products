module Spree
  module RelatedProductsHelper
    def product_relations_by_type(relation_type)
      return [] if product_relation_types.none? || !@product.respond_to?(:relations)

      current_store.products.
        available.not_discontinued.
        joins(:reverse_relations).
        where(spree_relations: { relation_type: relation_type, relatable_id: @product.id, relatable_type: 'Spree::Product' }).
        includes(
          :tax_category,
          master: [
            :prices,
            { images: { attachment_attachment: :blob } },
          ]
        ).
        distinct(false).reorder('spree_relations.position').
        limit(Spree::Config[:products_per_page])
    end
  end
  
  # TODO: move all gem-related code from spree and spree_frontend gems
  # to this gem, and then do this in the proper way.
  ProductsHelper.prepend RelatedProductsHelper
end