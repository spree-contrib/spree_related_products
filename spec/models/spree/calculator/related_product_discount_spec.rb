RSpec.describe Spree::Calculator::RelatedProductDiscount, type: :model do
  subject { described_class.new }

  context '.description' do
    it 'outputs relation product discount' do
      expect(subject.description).to eq Spree.t(:related_product_discount)
    end
  end

  describe '.compute(object)' do
    it 'returns nil with empty Array' do
      expect(subject.compute([])).to be_nil
    end

    it 'returns nil unless order is eligible' do
      empty_order = double('Spree::Order')
      allow(empty_order).to receive(:line_items).and_return([])
      expect(subject.compute(empty_order)).to be_nil
    end

    context 'with order' do
      before do
        @order    = double('Spree::Order')
        product   = build_stubbed(:product)
        variant   = double('Spree::Variant', product: product)
        price     = double('Spree::Price', variant: variant, amount: 5.00)
        line_item = double('Spree::LineItem', variant: variant, order: @order, quantity: 1, price: 4.99)

        allow(variant).to receive(:default_price).and_return(price)
        allow(@order).to receive(:line_items).and_return([line_item])

        related_product = create(:product)
        relation_type   = create(:relation_type)

        create(:relation, relatable: product, related_to: related_product, relation_type: relation_type, discount_amount: 1.0)
      end

      it 'returns total count of Array' do
        objects = Array.new { @order }
        expect(subject.compute(objects)).to be_nil
      end

      it 'returns total count' do
        expect(subject.compute(@order)).to be_zero
      end
    end
  end
end
