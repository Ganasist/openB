class AddUniquenessIndexes < ActiveRecord::Migration
  def change
    remove_index :reviews, :job_id if index_exists?(:reviews, :job_id)
    add_index :reviews, :job_id, unique: true

    add_index :bids, [:contractor_id, :job_id], unique: true

    # add_index :rating_caches, [:cacheable_type, :cacheable_id], unique: true, if table_exists?(:rating_caches)
  end
end
