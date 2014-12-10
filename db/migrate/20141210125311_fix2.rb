class Fix2 < ActiveRecord::Migration
  def change
  	remove_column :jobs, :status, :integer, default: 0
    remove_index :jobs, :status if index_exists?(:jobs, :status)
  end
end
