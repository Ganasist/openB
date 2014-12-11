class AddStateToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :state, :string, default: 'searching'
  end
end
