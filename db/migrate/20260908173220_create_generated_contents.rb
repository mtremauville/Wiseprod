class CreateGeneratedContents < ActiveRecord::Migration[8.1]
  def change
    create_table :generated_contents do |t|
      t.string :content_type
      t.text :prompt
      t.text :response
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
