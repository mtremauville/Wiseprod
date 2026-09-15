class CreateCustomers < ActiveRecord::Migration[8.1]
  def change
    create_table :customers do |t|
      t.string :matricule
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :postal_address
      t.string :phone

      t.timestamps
    end
    add_index :customers, :matricule, unique: true
  end
end
