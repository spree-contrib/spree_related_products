class AddDiscountToRelation < SpreeExtension::Migration[4.2]
  def self.up
    add_column :relations, :discount_amount, :decimal, precision: 8, scale: 2, default: 0.0
  end

  def self.down
    remove_column :relations, :discount_amount
  end
end
