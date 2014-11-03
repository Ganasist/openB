class AddCategoriesToExamples < ActiveRecord::Migration
  def change
    add_column :examples, :categories, :text, array: true, default: []
  end
end
