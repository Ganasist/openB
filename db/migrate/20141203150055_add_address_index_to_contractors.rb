class AddAddressIndexToContractors < ActiveRecord::Migration
  def change
  	add_index :contractors, :address
  end
end
