class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :zip_code
      t.index :zip_code

      t.timestamps null: false
    end
  end
end