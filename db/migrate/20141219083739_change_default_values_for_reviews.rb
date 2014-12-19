class ChangeDefaultValuesForReviews < ActiveRecord::Migration
  def self.up
    change_column :reviews, :quality, :integer, null: false, default: 5
    change_column :reviews, :cost, :integer, null: false, default: 5
    change_column :reviews, :timeliness, :integer, null: false, default: 5
    change_column :reviews, :professionalism, :integer, null: false, default: 5
    change_column :reviews, :recommendability, :integer, null: false, default: 5
  end

  def self.down
    change_column :reviews, :quality, :integer
    change_column :reviews, :cost, :integer
    change_column :reviews, :timeliness, :integer
    change_column :reviews, :professionalism, :integer
    change_column :reviews, :recommendability, :integer
  end
end
