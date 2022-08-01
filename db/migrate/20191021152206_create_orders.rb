class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end

    add_index :orders, [:client_id, :organization_id], unique: true
  end
end
