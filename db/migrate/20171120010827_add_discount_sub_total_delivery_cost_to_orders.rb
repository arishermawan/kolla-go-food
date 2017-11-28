class AddDiscountSubTotalDeliveryCostToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :sub_total, :decimal
    add_column :orders, :discount, :decimal
    add_column :orders, :delivery_cost, :decimal
  end
end
