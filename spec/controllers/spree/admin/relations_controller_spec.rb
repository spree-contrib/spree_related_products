require 'spec_helper'

describe Spree::Admin::RelationsController do
  stub_authorization!

  let(:product) { create(:product) }
  after do
    Spree::Admin::RelationsController.clear_overrides!
  end
  it 'should respond to model_class as Spree::Relation' do
    controller.send(:model_class).should eql(Spree::Relation)
  end

  it "should not hard-delete shipping methods" do
    @other1 = create(:product)
    @relation_type = Spree::RelationType.create(name: "Related Products", applies_to: "Spree::Product")

    relations = Spree::Relation.create!(relatable: product, related_to: @other1, relation_type: @relation_type)
    relations.should_not_receive(:destroy)
    # relations.deleted_at.should be_nil
    # spree_delete :destroy, :id => 1
    # relations.deleted_at.should_not be_nil
  end
end