class AddCostAndDurationAndDurationUnitAndBidDateToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :cost, :integer
    add_column :jobs, :duration, :integer
    add_column :jobs, :duration_unit, :string
    add_column :jobs, :bid_date, :date
  end
end
