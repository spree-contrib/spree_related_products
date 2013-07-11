require 'spec_helper'

describe Spree::Admin::ProductsController do
  stub_authorization!

  let(:user) { create(:user) }
  let(:product) { create(:product) }

  before { controller.stub spree_current_user: user }

  context "#related" do
  end
end
