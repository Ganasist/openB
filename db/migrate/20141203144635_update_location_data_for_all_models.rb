class UpdateLocationDataForAllModels < ActiveRecord::Migration
  def change
  	remove_column :contractors, :city, :string
  	remove_column :contractors, :zip_code, :integer
  	remove_column :contractors, :state, :string

  	remove_column :users, :city, :string
  	remove_column :users, :zip_code, :integer
  	remove_column :users, :state, :string

  	remove_column :examples, :zip_code, :integer

  	add_column :examples, :latitude, :float
  	add_column :examples, :longitude, :float
  	add_index :examples, :latitude
    add_index :examples, :longitude

    remove_column :jobs, :zip_code, :integer
  end
end
