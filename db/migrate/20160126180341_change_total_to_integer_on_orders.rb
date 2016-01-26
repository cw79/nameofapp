class ChangeTotalToIntegerOnOrders < ActiveRecord::Migration
  def up
  	change_column :orders, :total, 'integer USING CAST(total AS integer)'
  end
end
