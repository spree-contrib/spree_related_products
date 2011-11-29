class Spree::Relation < ActiveRecord::Base
  belongs_to :relation_type
  belongs_to :relatable, :polymorphic => true
  belongs_to :related_to, :polymorphic => true

  validates_presence_of :relation_type, :relatable, :related_to
end
