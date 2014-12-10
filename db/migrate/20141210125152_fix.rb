class Fix < ActiveRecord::Migration
  def change
  	remove_column :jobs, :city, :string if column_exists?(:jobs, :city)
  	remove_column :jobs, :state, :string if column_exists?(:jobs, :state)

	  unless  column_exists?(:jobs, :status) do 
	  	add_column :jobs, :status, :integer, default: 0
	    add_index :jobs, :status, name: 'index_statuses_on_searching',  where: 'status = 0'
	    add_index :jobs, :status, name: 'index_statuses_on_in_progress', where: 'status = 1'
	    add_index :jobs, :status, name: 'index_statuses_on_completed',where: 'status = 2'
	    add_index :jobs, :status, name: 'index_statuses_on_canceled',where: 'status = 3'
	  end
  end
end