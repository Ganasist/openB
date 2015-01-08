class AddUniquenessIndexes < ActiveRecord::Migration
  def change
    remove_index :reviews, :job_id if index_exists?(:reviews, :job_id)
    add_index :reviews, :job_id, unique: true

    add_index :bids, [:contractor_id, :job_id], unique: true
  end
end
