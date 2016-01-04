class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.binary :binary_data
      t.references :person, index: true, foreign_key: { on_delete: :cascade }

      t.timestamps null: false
    end
  end
end
