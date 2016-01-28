class AddDescriptionIndexToProducts < ActiveRecord::Migration
  def change
  	add_index :products, :description
  end
end
