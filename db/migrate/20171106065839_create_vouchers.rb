class CreateVouchers < ActiveRecord::Migration[5.1]
  def change
    create_table :vouchers do |t|
      t.string :code
      t.date :valid_from
      t.date :valid_through
      t.decimal :amount
      t.integer :unit_type
      t.decimal :max_amount

      t.timestamps
    end
  end
end
