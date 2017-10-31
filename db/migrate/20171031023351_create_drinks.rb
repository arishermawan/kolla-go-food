class CreateDrinks < ActiveRecord::Migration[5.1]
  def change
    create_table :drinks do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.decimal :price, precision:8, scale:2

      t.timestamps
    end
  end
end
