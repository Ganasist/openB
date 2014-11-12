class ModifyCommentsTable < ActiveRecord::Migration
  def change
  	remove_column :comments, :user_id, :integer, null: false
  	remove_column :comments, :parent_id, :integer
  end
end
