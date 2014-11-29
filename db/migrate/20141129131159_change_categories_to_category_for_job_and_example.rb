class ChangeCategoriesToCategoryForJobAndExample < ActiveRecord::Migration
  def change
  	remove_column :jobs, :categories, :text, array: true, default: []
  	remove_column :examples, :categories, :text, array: true, default: []

  	add_column :jobs, :category, :string
  	add_column :examples, :category, :string
  end
end
