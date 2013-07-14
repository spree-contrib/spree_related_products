require 'spec_helper'

describe Spree::Admin::RelationsController do
  stub_authorization!

  let(:user) { create(:user) }
  let(:product) { create(:product) }

  before { controller.stub spree_current_user: user }
  after  { Spree::Admin::RelationsController.clear_overrides! }

  before do
    @other1 = create(:product)
    @relation_type = Spree::RelationType.create(name: "Related Products", applies_to: "Spree::Product")
    @relation = Spree::Relation.create!(relatable: product, related_to: @other1, relation_type: @relation_type)
  end

  context "model_class" do
    it "respond to model_class as Spree::Relation" do
      controller.send(:model_class).should eql(Spree::Relation)
    end
  end

  pending "#create" do
    it "should be respond relations" do
      spree_post :create, id: @relation.id, relation: { related_to_id: @other1.id }
      response.status.should eq 200
    end
  end

  context "#update" do
    it "redirect product/related url" do
      spree_post :update, { id: 1, relation: { discount_amount: 2.0 } }
      response.should redirect_to(spree.admin_product_path(@relation.relatable) + "/related")
    end
  end

  context "#destory" do
    it "redirect to product/related url" do
      spree_delete :destroy, id: 1
      response.status.should eq 406
    end
  end
end
