module Spree
  class Calculator::RelatedProductDiscount < Spree::Calculator
    preference :item_total_threshold, :decimal, :default => 5

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

      # related_to is the one that gets the discount
      product_ids = order.line_items.map{|i| i.variant.product_id}.uniq
      discounts = Spree::Relation.where(["discount_amount <> 0.0 AND related_to_type = ? AND related_to_id IN (?)", "Spree::Product", product_ids]).all.group_by(&:related_to_id)
      return if discounts.empty?

      total = 0
      order.line_items.each do |line_item|
        relations_for_line_item = discounts[line_item.variant.product_id]
        next if relations_for_line_item.blank?

        discount_percent = 0
        relations_for_line_item.each do |relation_for_line_item|
          if product_ids.include?( relation_for_line_item.relatable_id )
            # Apply the maximum available discount percentage
            discount_percent = [discount_percent,
                                relation_for_line_item.discount_amount].max
          end
        end
        discount = ((line_item.price * discount_percent / 100.0) * line_item.quantity).round(2)
        if line_item.respond_to?(:discount_percent)
          line_item.update_column( :discount_percent, discount_percent )
        end
        total += discount
      end

      total == 0 ? nil : total
    end

    def eligible?(order)
      product_ids = order.line_items.map{|i| i.variant.product_id}.uniq
      Spree::Relation.where(["discount_amount <> 0.0 AND related_to_type = ? AND related_to_id IN (?)", "Spree::Product", product_ids]).exists?
    end

  end
end