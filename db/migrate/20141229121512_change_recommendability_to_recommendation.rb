class ChangeRecommendabilityToRecommendation < ActiveRecord::Migration
  def change
    rename_column :reviews, :recommendability, :recommendation
  end
end
