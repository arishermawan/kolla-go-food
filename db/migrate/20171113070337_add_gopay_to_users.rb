class AddGopayToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :gopay, :decimal, default:200000, null:false
  end
end
