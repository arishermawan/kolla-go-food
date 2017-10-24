class CreateBuyers < ActiveRecord::Migration[5.1]
  def change
    create_table :buyers do |t|
      t.string :email
      t.string :name
      t.string :phone
      t.text :address

      t.timestamps
    end
  end
end
