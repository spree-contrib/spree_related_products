module SpreeRelatedProducts
  module ProductSerializerDecorator
    def self.prepended(base)

      base.has_many :relations, class_name: 'Spree::Relation'
    end
  end
end

Spree::V2::Storefront::ProductSerializer.prepend(SpreeRelatedProducts::ProductSerializerDecorator)