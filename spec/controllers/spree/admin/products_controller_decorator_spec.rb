describe Spree::Admin::ProductsController do
  stub_authorization!

  let(:user) { create(:user) }

  before { controller.stub(spree_current_user: user) }
  after  { Spree::Admin::ProductsController.clear_overrides! }

  context 'related' do
    it 'is not routable' do
      spree_get :related
      expect(response.status).to eq(200)
    end

    it 'respond to model_class as Spree::Relation' do
      expect(controller.send(:model_class)).to eq(Spree::Product)
    end
  end
end
