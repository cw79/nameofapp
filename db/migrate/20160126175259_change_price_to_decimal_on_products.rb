class ChangePriceToDecimalOnProducts < ActiveRecord::Migration
  def up
  	change_column :products, :price, 'decimal USING CAST(price AS decimal)'
  end
end
