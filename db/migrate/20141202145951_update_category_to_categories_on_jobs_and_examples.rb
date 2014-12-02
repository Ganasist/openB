class UpdateCategoryToCategoriesOnJobsAndExamples < ActiveRecord::Migration
  def change
  	remove_column :jobs, :category, :string
  	remove_column :examples, :category, :string


  	add_column :jobs, :categories, :text, array: true, default: []
  	add_column :examples, :categories, :text, array: true, default: []

  	add_index  :jobs, :categories, using: 'gin'
  	add_index  :examples, :categories, using: 'gin'
  end
end