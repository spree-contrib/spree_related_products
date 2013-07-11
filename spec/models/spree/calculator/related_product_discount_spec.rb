require 'spec_helper'


describe Spree::Calculator::RelatedProductDiscount do

  let(:user) { stub_model(Spree::LegacyUser, :email => "spree@example.com") }
  let(:order) { stub_model(Spree::Order, :user => user) }
  let(:product) { create(:product) }
  let(:variant) { create(:variant, :product => product) }
  let(:related_product_discount) { Spree::Calculator::RelatedProductDiscount.new }

  context "class" do
    describe ".description" do
      it "should output relation product discount" do
        expect(related_product_discount.description).to eq("Related Product Discount")
      end
    end
  end

  context "instance" do
    before do
      @other1 = create(:product)
      @relation_type = Spree::RelationType.create(name: "Related Products", applies_to: "Spree::Product")
      @relation = Spree::Relation.create!(relatable: product, related_to: @other1, relation_type: @relation_type, discount_amount: 1.0)
    end

    describe ".compute" do
      before do
        @order = create(:order, :user => user)
        @order.contents.add(variant, 1)

        @order.line_items = [create(:line_item, :price => 1.0, :quantity => 2),
                             create(:line_item, :price => 1.0, :quantity => 1)]
      end
      it "should return the number of total related products" do
        related_product_discount.compute(@order).should == nil
      end
    end

    describe ".eligible" do
      it "should output eligible Relations by " do

      end
    end
  #   describe ".relations" do
  #     it "has many relations" do
  #       @product.save!
  #       other1 = create(:product)
  #       other2 = create(:product)

  #       relation1 = Spree::Relation.create!(relatable: @product, related_to: other1, relation_type: @relation_type)
  #       relation2 = Spree::Relation.create!(relatable: @product, related_to: other2, relation_type: @relation_type)

  #       @product.reload
  #       @product.relations.should include(relation1)
  #       @product.relations.should include(relation2)
  #     end

  #     it "has many relations for different RelationTypes" do
  #       @product.save!
  #       other = create(:product)#valid_product!

  #       other_relation_type = Spree::RelationType.new(name: "Recommended Products")

  #       relation1 = Spree::Relation.create!(relatable: @product, related_to: other, relation_type: @relation_type)
  #       relation2 = Spree::Relation.create!(relatable: @product, related_to: other, relation_type: other_relation_type)

  #       @product.reload
  #       @product.relations.should include(relation1)
  #       @product.relations.should include(relation2)
  #     end
  #   end

  #   describe "RelationType finders" do
  #     before do
  #       @product.save!
  #       @other = create(:product)
  #       @relation = Spree::Relation.create!(relatable: @product, related_to: @other, relation_type: @relation_type)
  #       @product.reload
  #     end

  #     it "should return the relevant relations" do
  #       @product.related_products.should include(@other)
  #     end

  #     it "should be the pluralised form of the RelationType name" do
  #       @relation_type.update_attributes(name: 'Related Product')
  #       @product.related_products.should include(@other)
  #     end

  #     it "should not return relations for another RelationType" do
  #       @product.save!
  #       other2 = create(:product)

  #       other_relation_type = Spree::RelationType.new(name: "Recommended Products")

  #       relation1 = Spree::Relation.create!(relatable: @product, related_to: @other, relation_type: @relation_type)
  #       relation2 = Spree::Relation.create!(relatable: @product, related_to: other2, relation_type: other_relation_type)

  #       @product.reload
  #       @product.related_products.should include(@other)
  #       @product.related_products.should_not include(other2)
  #     end

  #     it "should not return Products that are deleted" do
  #       @other.update_attributes(deleted_at: Time.now)

  #       @product.related_products.should be_blank
  #     end

  #     it "should not return Products that are not yet available" do
  #       @other.update_attributes(available_on: Time.now + 1.hour)

  #       @product.related_products.should be_blank
  #     end

  #     it "should not return Products where available_on are blank" do
  #       @other.update_attributes(available_on: nil)

  #       @product.related_products.should be_blank
  #     end

  #     it "should return all results if .relation_filter is nil" do
  #       Spree::Product.should_receive(:relation_filter).and_return(nil)
  #       @other.update_attributes(available_on: Time.now + 1.hour)

  #       @product.related_products.should include(@other)
  #     end

  #     context "with an enhanced Product.relation_filter" do
  #       it "should restrict the filter" do
  #         relation_filter = Spree::Product.relation_filter
  #         Spree::Product.should_receive(:relation_filter).at_least(:once).and_return(relation_filter.includes(:master).where('spree_variants.cost_price > 20'))

  #         @other.master.update_attributes({cost_price: 10}, without_protection: true)

  #         other2 = create(:product)
  #         other2.master.update_attributes({cost_price: 30}, without_protection: true)
  #         relation = Spree::Relation.create!(relatable: @product, related_to: other2, relation_type: @relation_type)

  #         results = @product.related_products
  #         results.should_not include(@other)
  #         results.should include(other2)
  #       end
  #     end
  #   end
  # end

  # context "instance when relation_types table is missing" do
  #   it 'method missing should not throw ActiveRecord::StatementInvalid when the spree_relation_types table is missing' do
  #     Spree::Product.connection.rename_table('spree_relation_types', 'missing_relation_types')
  #     begin
  #       product = Spree::Product.new
  #       expect { product.foo }.to raise_error(NameError)
  #     ensure
  #       Spree::Product.connection.rename_table('missing_relation_types', 'spree_relation_types')
  #     end
  #   end
  end
end
