class AddSearchRadiusToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :search_radius, :integer
  end
end
