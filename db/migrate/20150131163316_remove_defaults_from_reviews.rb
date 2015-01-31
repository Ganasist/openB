class RemoveDefaultsFromReviews < ActiveRecord::Migration
  def change
    change_column :reviews, :quality, :integer, null: false, default: ""
    change_column :reviews, :cost, :integer, null: false, default: ""
    change_column :reviews, :timeliness, :integer, null: false, default: ""
    change_column :reviews, :professionalism, :integer, null: false, default: ""
    change_column :reviews, :recommendation, :integer, null: false, default: ""
  end
end
