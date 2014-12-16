class UpdateReviewsTable < ActiveRecord::Migration
  def change
    remove_column :reviews, :user_id, :integer
    remove_column :reviews, :job_id, :integer

    add_column :reviews, :quality, :integer
    add_column :reviews, :cost, :integer
    add_column :reviews, :timeliness, :integer
    add_column :reviews, :professionalism, :integer
    add_column :reviews, :recommendation, :integer

    add_column :reviews, :reviewable_id, :integer
    add_column :reviews, :reviewable_type, :string

    add_column :reviews, :reviewerable_id, :integer
    add_column :reviews, :reviewerable_type, :string

    add_index :reviews, [:reviewable_id, :reviewable_type]
    add_index :reviews, [:reviewerable_id, :reviewerable_type]
  end
end
