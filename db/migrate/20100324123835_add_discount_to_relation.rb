class AddDiscountToRelation < ActiveRecord::Migration
  def up
    add_column :relations, :discount_amount, :decimal, precision: 8, scale: 2, default: 0.0
  end

  def down
    remove_column :relations, :discount_amount
  end
end
