class ChangeBioToDescriptionOnContractors < ActiveRecord::Migration
  def change
  	rename_column :contractors, :bio, :description
  end
end
