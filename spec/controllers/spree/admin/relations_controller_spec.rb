require 'spec_helper'

describe Spree::Admin::RelationsController do
  
  stub_authorization!
  include Spree::TestingSupport::ControllerRequests

  it "should respond to model_class as Spree::Relation" do
    controller.send(:model_class).should eql(Spree::Relation)
  end

  context "POST#update_positions" do

    it "should return the correct position of the related products" do
      
      @product = FactoryGirl.create(:product)

      other1 = FactoryGirl.create(:product)
      other2 = FactoryGirl.create(:product)

      @relation_type = Spree::RelationType.create(:name => "Related Products", :applies_to => "Spree::Product")

      @relation = Spree::Relation.create!(:relatable => @product, :related_to => other1, :relation_type => @relation_type, :position => 0 )
      @relation2 = Spree::Relation.create!(:relatable => @product, :related_to => other2, :relation_type => @relation_type, :position => 1 )
      
      expect {
        spree_post :update_positions, :id => @relation.id, :positions => { @relation.id => '1', @relation2.id => '0' }, :format => "js"
        @relation.reload
      }.to change(@relation, :position).from(0).to(1)
    end
  end

end
