require 'spec_helper'

describe Spree::Product do
  context 'class' do
    describe '.relation_types' do
      it 'return all the RelationTypes in use for this Product' do
        relation_type = create(:relation_type)
        Spree::Product.relation_types.should include(relation_type)
      end
    end
  end

  context 'relations' do
    it { should have_many(:relations) }
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
        @product.relations.should include(relation1)
        @product.relations.should include(relation2)
      end

      it 'has many relations for different RelationTypes' do
        other_relation_type = Spree::RelationType.new(name: 'Recommended Products')

        relation1 = create(:relation, relatable: @product, related_to: other1, relation_type: @relation_type)
        relation2 = create(:relation, relatable: @product, related_to: other1, relation_type: other_relation_type)

        @product.reload
        @product.relations.should include(relation1)
        @product.relations.should include(relation2)
      end
    end

    describe 'RelationType finders' do
      before do
        @relation = create(:relation, relatable: @product, related_to: other1, relation_type: @relation_type)
        @product.reload
      end

      it 'return the relevant relations' do
        @product.related_products.should include(other1)
      end

      it 'recognize the method with has_related_products?(method)' do
        @product.has_related_products?('related_products').should be_true
      end

      it 'not recognize non-existent methods with has_related_products?(method)' do
        @product.has_related_products?('unrelated_products').should_not be_true
      end

      it 'is the pluralised form of the RelationType name' do
        @relation_type.update_attributes(name: 'Related Product')
        @product.related_products.should include(other1)
      end

      it 'does not return relations for another RelationType' do
        other_relation_type = Spree::RelationType.new(name: 'Recommended Products')

        relation1 = create(:relation, relatable: @product, related_to: other1, relation_type: @relation_type)
        relation2 = create(:relation, relatable: @product, related_to: other2, relation_type: other_relation_type)

        @product.reload
        @product.related_products.should include(other1)
        @product.related_products.should_not include(other2)
      end

      it 'does not return Products that are deleted' do
        other1.update_attributes(deleted_at: Time.now)
        @product.related_products.should be_blank
      end

      it 'does not return Products that are not yet available' do
        other1.update_attributes(available_on: Time.now + 1.hour)
        @product.related_products.should be_blank
      end

      it 'does not return Products where available_on are blank' do
        other1.update_attributes(available_on: nil)
        @product.related_products.should be_blank
      end

      it 'return all results when .relation_filter is nil' do
        Spree::Product.should_receive(:relation_filter).and_return(nil)
        other1.update_attributes(available_on: Time.now + 1.hour)
        @product.related_products.should include(other1)
      end

      context 'with an enhanced Product.relation_filter' do
        it 'restrict the filter' do
          relation_filter = Spree::Product.relation_filter
          Spree::Product.should_receive(:relation_filter).at_least(:once).and_return(relation_filter.includes(:master).where('spree_variants.cost_price > 20'))

          other1.master.update_attributes({cost_price: 10})
          other2.master.update_attributes({cost_price: 30})

          relation = create(:relation, relatable: @product, related_to: other2, relation_type: @relation_type)
          results = @product.related_products
          results.should_not include(other1)
          results.should include(other2)
        end
      end
    end
  end

  context 'instance when relation_types table is missing' do
    it 'method missing should not throw ActiveRecord::StatementInvalid when the spree_relation_types table is missing' do
      Spree::Product.connection.rename_table('spree_relation_types', 'missing_relation_types')
      begin
        product = Spree::Product.new
        expect { product.foo }.to raise_error(NameError)
      ensure
        Spree::Product.connection.rename_table('missing_relation_types', 'spree_relation_types')
      end
    end
  end
end
