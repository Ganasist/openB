class AddSearchRadiusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :search_radius, :integer
  end
end
