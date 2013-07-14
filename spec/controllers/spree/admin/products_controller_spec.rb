require 'spec_helper'

describe Spree::Admin::ProductsController do
  stub_authorization!

  let(:user) { create(:user) }
  let(:product) { create(:product) }

  before { controller.stub spree_current_user: user }

  after { Spree::Admin::ProductsController.clear_overrides! }

  context "#related" do
    it "respond to model_class as Spree::Relation" do
      controller.send(:model_class).should eql(Spree::Product)
    end
  end
end
