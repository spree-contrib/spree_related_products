class AddPositionToSpreeRelations < ActiveRecord::Migration
  def change
    add_column :spree_relations, :position, :integer
  end
end
