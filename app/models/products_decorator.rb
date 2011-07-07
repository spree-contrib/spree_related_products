module SpreeRelatedProducts
  module ProductDecorator
    def self.included(target)
      target.class_eval do
        has_many :relations, :as => :relatable

        # Returns all the RelationTypes which apply_to this class.
        def self.relation_types
          RelationType.find_all_by_applies_to(self.to_s, :order => :name)
        end

        # The AREL Relations that will be used to filter the resultant items.
        #
        # By default this will remove any items which are deleted, or not yet available.
        #
        # You can override this method to fine tune the filter. For example,
        # to only return Products with more than 2 items in stock, you could
        # do the following:
        #
        #   def self.relation_filter
        #     set = super
        #     set.where('products.count_on_hand >= 2')
        #   end
        #
        # This could also feasibly be overridden to sort the result in a
        # particular order, or restrict the number of items returned.
        def self.relation_filter
          where('products.deleted_at' => nil).where('products.available_on IS NOT NULL').where('products.available_on <= ?', Time.now)
        end

        # Decides if there is a relevant RelationType related to this class
        # which should be returned for this method.
        #
        # If so, it calls relations_for_relation_type. Otherwise it passes
        # it up the inheritance chain.
        def method_missing(method, *args)
          relation_type =  self.class.relation_types.detect { |rt| rt.name.downcase.gsub(" ", "_").pluralize == method.to_s.downcase }

          if relation_type.nil?
            super
          else
            relations_for_relation_type(relation_type)
          end
        end

      end
    end

private
    # Returns all the Products that are related to this record for the given RelationType.
    #
    # Uses the Relations to find all the related items, and then filters
    # them using +Product.relation_filter+ to remove unwanted items.
    def relations_for_relation_type(relation_type)
      # Find all the relations that belong to us for this RelationType
      related_ids = relations.where(:relation_type_id => relation_type.id).select(:related_to_id).collect(&:related_to_id)

      # Construct a query for all these records
      result = self.class.where(:id => related_ids)

      # Merge in the relation_filter if it's available
      result = result.merge(self.class.relation_filter.scoped) if relation_filter

      result
    end

    # Simple accessor for the class-level relation_filter.
    # Could feasibly be overloaded to filter results relative to this
    # record (eg. only higher priced items)
    def relation_filter
      self.class.relation_filter
    end
  end
end

Product.send(:include, SpreeRelatedProducts::ProductDecorator)
