class ChnageRecommendationToRecommendabilityOnReviews < ActiveRecord::Migration
  def change
    rename_column :reviews, :recommendation, :recommendability
  end
end
