class ChangeZipCodeOnContractors < ActiveRecord::Migration
  def change
  	remove_column :contractors, :zip_code, :integer, array: true, default: []
  	add_column :contractors, :zip_code, :integer
  end
end
