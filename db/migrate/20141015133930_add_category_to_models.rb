class AddCategoryToModels < ActiveRecord::Migration
  def change
    add_column :contractors, :categories, :string, array: true, default: []
    # add_column :posts, :categories, :string, array: true, default: []
  end
end
