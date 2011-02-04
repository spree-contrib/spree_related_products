require 'spree_core'
require 'spree_related_products_hooks'

module SpreeRelatedProducts
  class Engine < Rails::Engine

    def self.activate

      # Calculator::RelatedProductDiscount.register

      Product.class_eval do
        has_many :relations, :as => :relatable

        def self.relation_types
          RelationType.find_all_by_applies_to(self.to_s, :order => :name)
        end

        #def method_missing(method, *args)
        #  relation_type =  self.class.relation_types.detect { |rt| rt.name.downcase.gsub(" ", "_").pluralize == method.to_s.downcase }
        #
        #  if relation_type.nil?
        #    super
        #  else
        #    relations.find_all_by_relation_type_id(relation_type.id).map(&:related_to).select {|product| product.deleted_at.nil? && product.available_on <= Time.now()}
        #  end
        #
        #end
      end

      Admin::ProductsController.class_eval do
        def related
          load_object
          @relation_types = Product.relation_types
        end
      end

    end

    config.autoload_paths += %W(#{config.root}/lib #{config.root}/app/models/calculator)
    config.to_prepare &method(:activate).to_proc

  end
end

