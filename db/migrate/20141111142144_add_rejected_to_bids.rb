class AddRejectedToBids < ActiveRecord::Migration
  def change
    add_column :bids, :rejected, :boolean, default: false
  end
end
