class AddPositionToRelation < ActiveRecord::Migration
  def self.up
    add_column :relations, :position, :integer
  end

  def self.down
    remove_column :relations, :position
  end
end
