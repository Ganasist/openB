class RemovePortfoliosAndExamples < ActiveRecord::Migration
  def change
  	drop_table :portfolios
  	# drop_table :examples
  end
end
