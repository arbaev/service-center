class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :inn, null: false
      t.string :ogrn, null: false
      t.references :org_type, foreign_keys: true

      t.timestamps
    end
  end
end
