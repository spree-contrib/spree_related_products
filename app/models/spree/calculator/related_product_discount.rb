module Spree
  class Calculator::RelatedProductDiscount < Spree::Calculator
    # preference :item_total_threshold, :decimal, :default => 5
    # attr_accessible :preferred_item_total_threshold

    def self.description
      I18n.t("related_product_discount")
    end

    def compute(object)
      if object.is_a?(Array)
        return if object.empty?
        order = object.first.order
      else
        order = object
      end

      return unless eligible?(order)
      total = order.line_items.inject(0) do |total, line_item|
        relations =  Spree::Relation.find(:all, :conditions => ["discount_amount <> 0.0 AND relatable_type = ? AND relatable_id = ?", "Spree::Product", line_item.variant.product.id])
        discount_applies_to = relations.map {|rel| rel.related_to.master }

        order.line_items.each do |li|
          if discount_applies_to.include? li.variant
            discount = relations.detect {|rel| rel.related_to.master == li.variant}.discount_amount

            discount = li.variant.price * discount / 100

            total += if li.quantity < line_item.quantity
              (discount * li.quantity)
            else
              (discount * line_item.quantity)
            end
          end
        end

        total
      end

      total == 0 ? nil : total
    end

    def eligible?(order)
      order.line_items.any? { |line_item| Spree::Relation.exists?(["discount_amount <> 0.0 AND relatable_type = ? AND relatable_id = ?", "Spree::Product", line_item.variant.product.id])}
    end

  end
end
