class AddCommenterableToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :commenterable, polymorphic: true, index: true
  end
end
