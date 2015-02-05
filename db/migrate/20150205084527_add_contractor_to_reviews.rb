class AddContractorToReviews < ActiveRecord::Migration
  def change
    add_reference :reviews, :contractor, index: true
  end
end
