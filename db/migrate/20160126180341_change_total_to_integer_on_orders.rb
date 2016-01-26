class ChangeTotalToIntegerOnOrders < ActiveRecord::Migration
  def change
  	change_column :orders, :total, :integer
  end
end
