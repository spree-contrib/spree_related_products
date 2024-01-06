# frozen_string_literal: true

class Spree::RelationType < ActiveRecord::Base
  has_many :relations, dependent: :destroy

  validates :name, :applies_to, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
