class AddCategoryToDrink < ActiveRecord::Migration[5.1]
  def change
    add_column :drinks, :category_id, :integer
  end
end
