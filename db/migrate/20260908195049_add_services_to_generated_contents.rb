class AddServicesToGeneratedContents < ActiveRecord::Migration[8.1]
  def change
    add_column :generated_contents, :services, :string
  end
end
