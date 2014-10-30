class AddBiddingPeriodToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :bidding_period, :date

    remove_column :jobs, :cost, :integer
  end
end
