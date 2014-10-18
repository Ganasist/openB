class AddAttributesToUsersAndContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :phone, :string
    add_column :users, :phone, :string

    add_column :contractors, :address, :string
    add_column :contractors, :city, :string
  end
end
