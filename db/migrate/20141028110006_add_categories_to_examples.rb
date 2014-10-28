class AddCategoriesToExamples < ActiveRecord::Migration
  def change
  	add_column :examples, :categories, :string, array: true, default: []
  end
end
