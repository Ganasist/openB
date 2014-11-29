class ChangeJobExampleCategoryType < ActiveRecord::Migration
  def change
  	change_column :jobs, :category, :text
  	change_column :examples, :category, :text
  end
end
