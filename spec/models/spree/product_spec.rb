RSpec.describe Spree::Product, type: :model do
  context 'class' do
    describe '.relation_types' do
      it 'returns all the RelationTypes in use for this Product' do
        relation_type = create(:relation_type)
        expect(described_class.relation_types).to include(relation_type)
      end
    end
  end

  context 'relations' do
    it { is_expected.to have_many(:relations) }
  end

  context 'instance' do
    let(:other1) { create(:product) }
    let(:other2) { create(:product) }

    before do
      @product = create(:product)
      @relation_type = create(:relation_type, name: 'Related Products')
    end

    describe '.relations' do
      it 'has many relations' do
        relation1 = create(:relation, relatable: @product, related_to: other1, relation_type: @relation_type)
        relation2 = create(:relation, relatable: @product, related_to: other2, relation_type: @relation_type)

        @product.reload
        expect(@product.relations).to include(relation1)
        expect(@product.relations).to include(relation2)
      end

      it 'has many relations for different RelationTypes' do
        other_relation_type = Spree::RelationType.new(name: 'Recommended Products')

        relation1 = create(:relation, relatable: @product, related_to: other1, relation_type: @relation_type)
        relation2 = create(:relation, relatable: @product, related_to: other1, relation_type: other_relation_type)

        @product.reload
        expect(@product.relations).to include(relation1)
        expect(@product.relations).to include(relation2)
      end
    end

    describe 'RelationType finders' do
      before do
        @relation = create(:relation, relatable: @product, related_to: other1, relation_type: @relation_type)
        @product.reload
      end

      it 'returns the relevant relations' do
        expect(@product.related_products).to include(other1)
      end

      it 'recognizes the method with has_related_products?(method)' do
        expect(@product.has_related_products?('related_products')).to be_truthy
      end

      it 'does not recognize non-existent methods with has_related_products?(method)' do
        expect(@product.has_related_products?('unrelated_products')).not_to be_truthy
      end

      it 'is the pluralised form of the RelationType name' do
        @relation_type.update(name: 'Related Product')
        expect(@product.related_products).to include(other1)
      end

      it 'does not return relations for another RelationType' do
        other_relation_type = Spree::RelationType.new(name: 'Recommended Products')

        create(:relation, relatable: @product, related_to: other1, relation_type: @relation_type)
        create(:relation, relatable: @product, related_to: other2, relation_type: other_relation_type)

        @product.reload
        expect(@product.related_products).to include(other1)
        expect(@product.related_products).not_to include(other2)
      end

      it 'does not return Products that are deleted' do
        other1.update(deleted_at: Time.now)
        expect(@product.related_products).to be_blank
      end

      it 'does not return Products that are not yet available' do
        other1.update(available_on: Time.now + 1.hour)
        expect(@product.related_products).to be_blank
      end

      it 'does not return Products where available_on are blank' do
        other1.update(available_on: nil)
        expect(@product.related_products).to be_blank
      end

      it 'returns all results when .relation_filter is nil' do
        expect(described_class).to receive(:relation_filter).and_return(nil)
        other1.update(available_on: Time.now + 1.hour)
        expect(@product.related_products).to include(other1)
      end

      context 'with an enhanced Product.relation_filter' do
        it 'restricts the filter' do
          relation_filter = described_class.relation_filter
          expect(described_class).to receive(:relation_filter).at_least(:once).and_return(relation_filter.includes(:master).where('spree_variants.cost_price > 20'))

          other1.master.update(cost_price: 10)
          other2.master.update(cost_price: 30)

          create(:relation, relatable: @product, related_to: other2, relation_type: @relation_type)
          results = @product.related_products
          expect(results).not_to include(other1)
          expect(results).to include(other2)
        end
      end
    end
  end

  xcontext 'instance when relation_types table is missing' do
    it 'method missing should not throw ActiveRecord::StatementInvalid when the spree_relation_types table is missing', with_truncation: true do
      described_class.connection.rename_table('spree_relation_types', 'missing_relation_types')
      begin
        product = described_class.new
        expect { product.foo }.to raise_error(NameError)
      ensure
        described_class.connection.rename_table('missing_relation_types', 'spree_relation_types')
      end
    end
  end
end
