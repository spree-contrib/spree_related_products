require 'spec_helper'

describe Product do

  context "class" do
    describe ".relation_types" do
      it "should return all the RelationTypes in use for this Product" do
        relation_type = RelationType.create!(:name => "Related Products", :applies_to => "Product")
        Product.relation_types.should include(relation_type)
      end
    end
  end

  context "instance" do
    before(:each) do
      @product = valid_product(:name => 'Product')
      @relation_type = RelationType.create(:name => "Related Products", :applies_to => "Product")
    end

    describe ".relations" do
      it "has many relations" do
        @product.save!
        other1 = valid_product!
        other2 = valid_product!

        relation1 = Relation.create!(:relatable => @product, :related_to => other1, :relation_type => @relation_type)
        relation2 = Relation.create!(:relatable => @product, :related_to => other2, :relation_type => @relation_type)

        @product.reload
        @product.relations.should include(relation1)
        @product.relations.should include(relation2)
      end

      it "has many relations for different RelationTypes" do
        @product.save!
        other = valid_product!

        other_relation_type = RelationType.new(:name => "Recommended Products")

        relation1 = Relation.create!(:relatable => @product, :related_to => other, :relation_type => @relation_type)
        relation2 = Relation.create!(:relatable => @product, :related_to => other, :relation_type => other_relation_type)

        @product.reload
        @product.relations.should include(relation1)
        @product.relations.should include(relation2)
      end
    end

    describe "RelationType finders" do
      before(:each) do
        @product.save!
        @other = valid_product!
        @relation = Relation.create!(:relatable => @product, :related_to => @other, :relation_type => @relation_type)
        @product.reload
      end

      it "should return the relevant relations" do
        @product.related_products.should include(@other)
      end

      it "should be the pluralised form of the RelationType name" do
        @relation_type.update_attributes(:name => 'Related Product')
        @product.related_products.should include(@other)
      end

      it "should not return relations for another RelationType" do
        @product.save!
        other2 = valid_product!

        other_relation_type = RelationType.new(:name => "Recommended Products")

        relation1 = Relation.create!(:relatable => @product, :related_to => @other, :relation_type => @relation_type)
        relation2 = Relation.create!(:relatable => @product, :related_to => other2, :relation_type => other_relation_type)

        @product.reload
        @product.related_products.should include(@other)
        @product.related_products.should_not include(other2)
      end

      it "should not return Products that are deleted" do
        @other.update_attributes(:deleted_at => Time.now)

        @product.related_products.should be_blank
      end

      it "should not return Products that are not yet available" do
        @other.update_attributes(:available_on => Time.now + 1.hour)

        @product.related_products.should be_blank
      end

      it "should not return Products where available_on are blank" do
        pending "uses a <= which fails on nil"
        @other.update_attributes(:available_on => nil)

        @product.related_products.should be_blank
      end
    end
  end
end
