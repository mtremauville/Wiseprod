class CreateReceiptItems < ActiveRecord::Migration[8.1]
  def change
    create_table :receipt_items do |t|
      t.references :receipt, null: false, foreign_key: true
      t.string :sku
      t.string :name
      t.integer :quantity
      t.decimal :unit_price

      t.timestamps
    end
  end
end
