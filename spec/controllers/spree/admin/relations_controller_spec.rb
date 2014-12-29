describe Spree::Admin::RelationsController do
  stub_authorization!

  let(:user)     { create(:user) }
  let!(:product) { create(:product) }
  let!(:other1)  { create(:product) }

  let!(:relation_type) { create(:relation_type) }
  let!(:relation) { create(:relation, relatable: product, related_to: other1, relation_type: relation_type, position: 0) }

  before { controller.stub(spree_current_user: user) }
  after  { Spree::Admin::ProductsController.clear_overrides! }

  context 'model_class' do
    it 'respond to model_class as Spree::Relation' do
      expect(controller.send(:model_class)).to eq(Spree::Relation)
    end
  end

  describe 'with JS' do
    let(:valid_params) do
      { format: :js,
        product_id: product.id,
        relation: { related_to_id: other1.id,
                    relation_type: { name: relation_type.name,
                                     applies_to: relation_type.applies_to } } }
    end

    context '#create' do
      it 'is not routable' do
        spree_post :create, valid_params
        expect(response.status).to eq(200)
      end

      xit 'return success with valid params' do
        pending 'fix hash params'
        expect {
          spree_post :create, valid_params
        }.to change(Spree::Relation, :count).by(1)
      end

      it 'raise error with invalid params' do
        expect {
          spree_post :create, { format: :js }
        }.to raise_error
      end
    end

    context '#update' do
      it 'redirect product/related url' do
        spree_post :update, { id: 1, relation: { discount_amount: 2.0 } }
        expect(response).to redirect_to(spree.admin_product_path(relation.relatable) + '/related')
      end
    end

    context '#destory with' do
      it 'record successfully' do
        expect {
          spree_delete :destroy, { id: 1, format: :js }
        }.to change(Spree::Relation, :count).by(-1)
      end
    end

    context '#update_positions' do
      it 'return the correct position of the related products' do
        other2    = create(:product)
        relation2 = create(:relation, relatable: product, related_to: other2, relation_type: relation_type, position: 1)

        expect {
          spree_post :update_positions, { id: relation.id, positions: { relation.id => '1', relation2.id => '0' }, format: :js }
          relation.reload
        }.to change(relation, :position).from(0).to(1)
      end
    end
  end
end
