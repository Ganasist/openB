class RemoveCommenterFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :commenter_id, :integer
    remove_column :comments, :commenter_type, :string
  end
end
