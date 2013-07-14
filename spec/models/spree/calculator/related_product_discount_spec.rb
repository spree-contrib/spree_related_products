require 'spec_helper'

describe Spree::Calculator::RelatedProductDiscount do
  let(:user) { create(:user) }
  let(:related_product_discount) { Spree::Calculator::RelatedProductDiscount.new }

  describe "class" do
    context ".description" do
      it "output relation product discount" do
        related_product_discount.description.should eq Spree.t(:related_product_discount)
      end
    end
  end

  describe "instance" do
    let(:order)   { create(:order, user: user) }
    let(:product) { create(:product) }
    let(:variant) { create(:variant, product: product) }

    let(:other1) { create(:product) }
    let(:other2) { create(:product) }

    before do
      @relation_type = Spree::RelationType.create(name: "Related Products", applies_to: "Spree::Product")
      @relation      = Spree::Relation.create!(relatable: product, related_to: other1, relation_type: @relation_type, discount_amount: 1.0)
    end

    context ".compute" do
      before do
        order.contents.add(variant, 1)
        order.line_items = [create(:line_item, price: 1.0, quantity: 2),
                            create(:line_item, price: 1.0, quantity: 1)]
      end

      it "return the number of total related products" do
        related_product_discount.compute(order).should be_nil
      end
    end

    context ".eligible" do
      it "output eligible Relations by " do
      end
    end

    context ".relations" do
      it "has many relations" do
        relation1 = Spree::Relation.create!(relatable: product, related_to: other1, relation_type: @relation_type)
        relation2 = Spree::Relation.create!(relatable: product, related_to: other2, relation_type: @relation_type)

        product.reload
        product.relations.should include(relation1)
        product.relations.should include(relation2)
      end

      it "has many relations for different RelationTypes" do
        other_relation_type = Spree::RelationType.new(name: "Recommended Products")

        relation1 = Spree::Relation.create!(relatable: product, related_to: other1, relation_type: @relation_type)
        relation2 = Spree::Relation.create!(relatable: product, related_to: other1, relation_type: other_relation_type)

        product.reload
        product.relations.should include(relation1)
        product.relations.should include(relation2)
      end
    end

    describe "RelationType finders" do
      before do
        @relation = Spree::Relation.create!(relatable: product, related_to: other1, relation_type: @relation_type)
        product.reload
      end

      it "return the relevant relations" do
        product.related_products.should include(other1)
      end

      it "should be the pluralised form of the RelationType name" do
        @relation_type.update_attributes(name: 'Related Product')
        product.related_products.should include(other1)
      end

      it "should not return relations for another RelationType" do
        other_relation_type = Spree::RelationType.new(name: "Recommended Products")

        relation1 = Spree::Relation.create!(relatable: product, related_to: other1, relation_type: @relation_type)
        relation2 = Spree::Relation.create!(relatable: product, related_to: other2, relation_type: other_relation_type)

        product.reload
        product.related_products.should include(other1)
        product.related_products.should_not include(other2)
      end

      it "should not return Products that are deleted" do
        other1.update_attributes(deleted_at: Time.now)
        product.related_products.should be_blank
      end

      it "should not return Products that are not yet available" do
        other1.update_attributes(available_on: Time.now + 1.hour)
        product.related_products.should be_blank
      end

      it "should not return Products where available_on are blank" do
        other1.update_attributes(available_on: nil)
        product.related_products.should be_blank
      end

      it "return all results if .relation_filter is nil" do
        Spree::Product.should_receive(:relation_filter).and_return(nil)
        other1.update_attributes(available_on: Time.now + 1.hour)
        product.related_products.should include(other1)
      end

      context "with an enhanced Product.relation_filter" do
        it "restrict the filter" do
          relation_filter = Spree::Product.relation_filter
          Spree::Product.should_receive(:relation_filter)
                        .at_least(:once)
                        .and_return(relation_filter.includes(:master)
                        .where("spree_variants.cost_price > 20"))

          other1.master.update_attributes({cost_price: 10}, without_protection: true)
          other2.master.update_attributes({cost_price: 30}, without_protection: true)

          relation = Spree::Relation.create!(relatable: product, related_to: other2, relation_type: @relation_type)

          results = product.related_products
          results.should_not include(other1)
          results.should include(other2)
        end
      end
    end
  end

  context "instance when relation_types table is missing" do
    it "method missing should not throw ActiveRecord::StatementInvalid when the spree_relation_types table is missing" do
      Spree::Product.connection.rename_table("spree_relation_types", "missing_relation_types")
      begin
        product = Spree::Product.new
        expect { product.foo }.to raise_error(NameError)
      ensure
        Spree::Product.connection.rename_table("missing_relation_types", "spree_relation_types")
      end
    end
  end
end
