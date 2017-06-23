module Spree
  class Calculator::RelatedProductDiscount < Spree::Calculator
    def self.description
      Spree.t(:related_product_discount)
    end

    def compute(line_item)
      return 0 unless eligible?(line_item)
      total = 0
      relations = Spree::Relation.where(*discount_query(line_item))
      discount_applies_to = relations.map {|rel| rel.related_to.master }

      order = line_item.order
      order.line_items.each do |li|
        next unless discount_applies_to.include? li.variant
        discount = relations.detect { |rel| rel.related_to.master == li.variant }.discount_amount
        if li.quantity < line_item.quantity
          total = (discount * li.quantity)
        else
          total = (discount * line_item.quantity)
        end
      end

      total
    end

    def eligible?(line_item)
      Spree::Relation.exists?(discount_query(line_item))
    end

    def discount_query(line_item)
      [
        'discount_amount <> 0.0 AND relatable_type = ? AND relatable_id = ?',
        'Spree::Product',
        line_item.variant.product.id
      ]
    end
  end
end
