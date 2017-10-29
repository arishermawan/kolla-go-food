class AddCategoryToFood < ActiveRecord::Migration[5.1]
  def change
    add_reference :foods, :category, foreign_key: true
  end
end
