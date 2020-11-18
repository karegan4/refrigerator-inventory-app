class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :category
      t.string :name
      t.integer :quantity
    end
  end
end
