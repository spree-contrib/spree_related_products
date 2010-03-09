class Admin::RelationsController < Admin::BaseController
  resource_controller
  belongs_to :product

  actions :create, :destroy

  create do
    flash nil
  end

  create.before do
    object.related_to = Variant.find(params[:relation][:related_to_id]).product
  end

  create.response do |wants|
    wants.html { render :partial => "admin/products/related_products_table", :locals => {:product => @product}, :layout => false}
  end

  destroy.success.wants.js { render_js_for_destroy }

end
