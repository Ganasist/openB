class CleanUpReviewsTable < ActiveRecord::Migration
  def change
    remove_column :reviews, :contractor_id, :integer
    remove_column :reviews, :user_id, :integer
    remove_column :reviews, :job_id, :integer    
  end
end
