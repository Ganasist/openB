class RemoveUniqenssConstraintOnJobsForContractors < ActiveRecord::Migration
  def change
    remove_index :jobs, :contractor_id if index_exists?(:jobs, :contractor_id)

    add_index :jobs, :contractor_id
  end
end
