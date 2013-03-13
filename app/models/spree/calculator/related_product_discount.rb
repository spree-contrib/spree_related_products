module Spree
  class Calculator::RelatedProductDiscount < Spree::Calculator

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
        discount_applies_to = relations.map {|rel| rel.related_to }

        order.line_items.each do |li|
          if discount_applies_to.include? li.product
            discount = relations.detect {|rel| rel.related_to == li.product}.discount_amount

            discount = li.price * discount / 100

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
      product_ids = order.line_items.map{ |line_item| line_item.variant.product_id}.uniq
      Spree::Relation.where(["discount_amount <> 0.0 AND related_to_type = ? AND related_to_id IN (?)", "Spree::Product", product_ids]).exists?
    end

  end
end
