module Spree
  module Admin
    class RelationsController < BaseController
      before_filter :load_data, :only => [:create, :destroy]

      respond_to :js, :html

      def create
        @relation = Relation.new(params[:relation])
        @relation.relatable = @product
        @relation.related_to = Spree::Variant.find(params[:relation][:related_to_id]).product
        @relation.save

        respond_with(@relation)
      end

      def update
        @relation = Relation.find(params[:id])
        @relation.update_attribute :discount_amount, params[:relation][:discount_amount] || 0

        redirect_to( related_admin_product_url(@relation.relatable) )
      end

      def update_positions
        params[:positions].each do |id, index|
          model_class.where(:id => id).update_all(:position => index)
        end
    
        respond_to do |format|
          format.js  { render :text => 'Ok' }
        end
      end

      def destroy
        @relation = Relation.find(params[:id])
        @relation.destroy

        #respond_with(@relation)
        redirect_to :back
      end

      private

      def load_data
        @product = Spree::Product.find_by_permalink(params[:product_id])
      end

      def model_class
        Spree::Relation
      end
    end
  end
end
