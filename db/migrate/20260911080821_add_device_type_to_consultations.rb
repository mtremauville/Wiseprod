class AddDeviceTypeToConsultations < ActiveRecord::Migration[8.1]
  def change
    add_column :consultations, :device_type, :string
  end
end
