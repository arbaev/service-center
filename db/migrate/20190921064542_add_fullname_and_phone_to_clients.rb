class AddFullnameAndPhoneToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :fullname, :string, null: false
    add_column :clients, :phone, :string, null: false

    add_index :clients, :phone, unique: true
  end
end
