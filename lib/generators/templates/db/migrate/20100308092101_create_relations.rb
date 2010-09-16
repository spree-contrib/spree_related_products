class CreateRelations < ActiveRecord::Migration
  def self.up
    create_table :relations, :force => true do |t|
      t.references :relation_type
      t.references :relatable, :polymorphic => true
      t.references :related_to, :polymorphic => true
      t.timestamps
    end
  end

  def self.down
    drop_table :relations
  end
end