RSpec.describe Spree::Admin::ProductsController, type: :controller do
  stub_authorization!

  let(:user) { create(:user) }
  let(:product) { create(:product) }

  before { allow(controller).to receive(:spree_current_user).and_return(user) }
  after  { Spree::Admin::ProductsController.clear_overrides! }

  context 'related' do
    it 'is not routable' do
      spree_get :related, id: product.id
      expect(response.status).to be(200)
    end

    it 'responds to model_class as Spree::Relation' do
      expect(controller.send(:model_class)).to eq Spree::Product
    end
  end
end
