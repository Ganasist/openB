class CreateExamples < ActiveRecord::Migration
  def change
    create_table :examples do |t|
      t.string :title
      t.integer :zip_code
      t.string :description
      t.integer :duration
      t.string :duration_unit
      t.integer :cost
      t.references :portfolio, index: true

      t.timestamps null: false
    end
  end
end
