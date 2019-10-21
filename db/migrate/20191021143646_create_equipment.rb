class CreateEquipment < ActiveRecord::Migration[6.0]
  def change
    create_table :equipment do |t|
      t.string :name, null: false
      t.string :kind, null: false
      t.string :sn, null: false
      t.belongs_to :organization, foreign_key: true

      t.timestamps
    end
  end
end
