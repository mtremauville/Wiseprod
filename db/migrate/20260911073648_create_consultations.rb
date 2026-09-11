class CreateConsultations < ActiveRecord::Migration[8.1]
  def change
    create_table :consultations do |t|
      t.string :usage_type
      t.string :budget_range
      t.string :mobility
      t.string :priority
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
