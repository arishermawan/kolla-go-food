class AddVoucherToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :voucher_id, :integer
  end
end
