class CreateFridgeFoods < ActiveRecord::Migration
  def change
    create_table :fridge_foods do |t|
      t.string :food 
      t.string :quantity
    end
  end
end
