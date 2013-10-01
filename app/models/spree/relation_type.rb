class Spree::RelationType < ActiveRecord::Base
  has_many :relations, :dependent => :destroy
end
