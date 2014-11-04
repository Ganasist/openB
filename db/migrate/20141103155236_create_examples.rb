class CreateExamples < ActiveRecord::Migration
  def change
    create_table :examples do |t|
    	t.string :title
      t.integer :zip_code
      t.string :description
      t.integer :duration
      t.string :duration_unit
      t.integer :cost
      t.text :categories, array: true, default: []
      t.attachment :image_before
      t.attachment :image_after
	    t.boolean :image_before_processing
	    t.boolean :image_after_processing

      t.references :contractor, index: true

      t.timestamps null: false
    end
  end
end