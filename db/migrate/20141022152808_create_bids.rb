class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.references :job, index: true
      t.references :contractor, index: true
      t.integer :cost
      t.integer :duration
      t.string :duration_unit
      t.boolean :accepted

      t.timestamps null: false
    end
  end
end
