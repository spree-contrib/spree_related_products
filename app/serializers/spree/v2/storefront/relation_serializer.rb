module Spree
  module V2
    module Storefront
      class RelationSerializer < BaseSerializer
        set_type :relation

        attributes :relation_type, :relatable, :related_to

      end
    end
  end
end