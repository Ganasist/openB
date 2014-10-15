class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.integer :zip_code
      t.references :user, index: true
      t.references :contractor, index: true

      t.timestamps null: false
    end
  end
end
