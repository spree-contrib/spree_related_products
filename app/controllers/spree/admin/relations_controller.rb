module Spree
	module Admin
		class RelationsController < BaseController
		  before_filter :load_data, :only => [:create, :destroy]

		  respond_to :js

		  def create
		    @relation = Relation.new(params[:relation])
		    @relation.relatable = @product
		    @relation.related_to = Spree::Variant.find(params[:relation][:related_to_id]).product
		    @relation.save

		    respond_with(@relation)
		  end

		  def destroy
		    @relation = Relation.find(params[:id])
		    @relation.destroy

		    respond_with(@relation)
		  end

		  private

	    def load_data
	      @product = Spree::Product.find_by_permalink(params[:product_id])
	    end
		end
	end
end
