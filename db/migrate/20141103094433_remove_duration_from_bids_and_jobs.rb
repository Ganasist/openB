class RemoveDurationFromBidsAndJobs < ActiveRecord::Migration
  def change
  	remove_column :bids, :duration, :integer
  	remove_column :bids, :duration_unit, :string

  	remove_column :jobs, :duration, :integer
  	remove_column :jobs, :duration_unit, :string

  	add_column :jobs, :cost, :integer
  end
end
