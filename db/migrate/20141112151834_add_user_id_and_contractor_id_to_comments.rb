class AddUserIdAndContractorIdToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :commenter, polymorphic: true, index: true
  end
end
