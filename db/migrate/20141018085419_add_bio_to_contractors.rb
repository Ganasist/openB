class AddBioToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :bio, :text
  end
end
