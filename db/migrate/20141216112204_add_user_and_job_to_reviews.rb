class AddUserAndJobToReviews < ActiveRecord::Migration
  def change
    add_reference :reviews, :user, index: true
    add_reference :reviews, :job, index: true
  end
end
