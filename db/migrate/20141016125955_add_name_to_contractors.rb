class AddNameToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :name, :string
  end
end
