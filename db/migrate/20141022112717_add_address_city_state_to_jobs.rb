class AddAddressCityStateToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :address, :string
    add_column :jobs, :city, :string
    add_column :jobs, :state, :string

    add_index :jobs, :address
  end
end
