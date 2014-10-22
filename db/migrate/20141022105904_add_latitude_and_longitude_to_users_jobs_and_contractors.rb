class AddLatitudeAndLongitudeToUsersJobsAndContractors < ActiveRecord::Migration
  def change
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float

    add_column :jobs, :latitude, :float
    add_column :jobs, :longitude, :float

    add_column :contractors, :latitude, :float
    add_column :contractors, :longitude, :float

    add_index :contractors, :latitude
    add_index :contractors, :longitude

    add_index :jobs, :latitude
    add_index :jobs, :longitude

    add_index :users, :latitude
    add_index :users, :longitude
  end
end
