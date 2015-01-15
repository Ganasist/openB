class RemoveLonLatFromExamples < ActiveRecord::Migration
  def change
    remove_column :examples, :longitude, :float
    remove_column :examples, :latitude, :float
  end
end
