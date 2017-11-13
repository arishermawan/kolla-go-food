class CreateFoodsTags < ActiveRecord::Migration[5.1]
  def change
    create_table :foods_tags, id: false do |t|
      t.belongs_to :food, index: true
      t.belongs_to :tag, index: true
    end
  end
end
