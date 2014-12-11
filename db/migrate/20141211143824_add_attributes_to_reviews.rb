class AddAttributesToReviews < ActiveRecord::Migration
  def change
    add_reference :reviews, :user, index: true
    add_reference :reviews, :contractor, index: true
  end
end
