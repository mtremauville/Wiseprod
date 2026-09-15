class CreateReceipts < ActiveRecord::Migration[8.1]
  def change
    create_table :receipts do |t|
      t.string :ticket_number
      t.references :customer, null: false, foreign_key: true
      t.decimal :total_ht
      t.decimal :total_ttc
      t.datetime :finalized_at

      t.timestamps
    end
    add_index :receipts, :ticket_number, unique: true
  end
end
