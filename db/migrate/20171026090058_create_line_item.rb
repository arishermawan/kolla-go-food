class CreateLineItem < ActiveRecord::Migration[5.1]
  def change
    create_table :line_items do |t|
      t.references :food, foreign_key: true
      t.belongs_to :cart, foreign_key: true
    end
  end
end
