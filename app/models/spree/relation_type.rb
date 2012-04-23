class Spree::RelationType < ActiveRecord::Base
  has_many :relations
  
  attr_accessible :name, :applies_to, :description
end
