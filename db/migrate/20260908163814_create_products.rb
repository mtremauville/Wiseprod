class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :category
      t.decimal :price
      t.text :sales_argument

      t.timestamps
    end
  end
end
