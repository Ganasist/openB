class ChangeBidAcceptToFalse < ActiveRecord::Migration
  def self.up
    change_column :bids, :accepted, :boolean, default: false
  end

  def self.down
    change_column :bids, :accepted, :boolean
  end
end
