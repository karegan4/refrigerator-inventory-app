class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.string :category
      t.string :name
      t.integer :quantity
    end
  end
end
