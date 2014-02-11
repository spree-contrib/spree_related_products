require 'spec_helper'

describe Spree::Calculator::RelatedProductDiscount do
  let(:user) { create(:user) }
  let(:related_product_discount) { Spree::Calculator::RelatedProductDiscount.new }

  describe 'instance' do
    context '.description' do
      it 'output relation product discount' do
        expect(related_product_discount.description).to eq Spree.t(:related_product_discount)
      end
    end
  end

  describe 'class' do
    before do
      @order    = stub_model(Spree::Order)
      product   = stub_model(Spree::Product)
      variant   = stub_model(Spree::Variant, product: product)
      price     = stub_model(Spree::Price, variant: variant, amount: 5.00)
      line_item = stub_model(Spree::LineItem, variant: variant, order: @order, quantity: 1, price: 4.99)

      variant.stub(default_price: price)
      @order.stub(line_items: [line_item])

      related_product = create(:product)
      relation_type   = create(:relation_type)

      create(:relation, relatable: product, related_to: related_product, relation_type: relation_type, discount_amount: 1.0)
    end

    context '.compute' do
      it 'return nil' do
        expect(related_product_discount.compute([])).to be_nil
      end

      it 'return nil unless order is eligible' do
        empty_order = stub_model(Spree::Order)
        expect(related_product_discount.compute(empty_order)).to be_nil
      end

      it 'return total count of array' do
        objects = Array.new { @order }
        expect(related_product_discount.compute(objects)).to be_nil
      end

      it 'return total count' do
        expect(related_product_discount.compute(@order)).to be_nil
      end
    end
  end
end