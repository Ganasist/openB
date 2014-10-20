class AddCityAndAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :city, :string
    add_column :users, :address, :string

    add_index :users, :city
    add_index :users, :address
  end
end
