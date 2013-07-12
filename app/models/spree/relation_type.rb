class Spree::RelationType < ActiveRecord::Base
  has_many :relations, dependent: :destroy

  attr_accessible :name, :applies_to, :description

  validates :name, :applies_to, presence: true
  validates :name, uniqueness: true
end
