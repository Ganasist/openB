class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :zip_code
      t.string :title
      t.string :description
      t.references :user, index: true
      t.references :contractor, index: true

      t.timestamps null: false
    end
  end
end
