class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.references :job, index: true
      t.references :contractor, index: true

      t.timestamps null: false
    end
  end
end
