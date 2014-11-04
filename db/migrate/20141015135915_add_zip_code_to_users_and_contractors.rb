class AddZipCodeToUsersAndContractors < ActiveRecord::Migration
  def change
    add_column :users, :zip_code, :integer
    add_column :contractors, :zip_code, :integer, array: true, default: []
    
    add_index  :users, :zip_code
    add_index  :contractors, :zip_code
    # add_index  :posts, :zip_code
  end
end
