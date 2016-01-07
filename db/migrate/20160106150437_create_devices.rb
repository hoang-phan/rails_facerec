class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :register_id

      t.timestamps null: false
    end

    add_index :devices, :register_id
  end
end
