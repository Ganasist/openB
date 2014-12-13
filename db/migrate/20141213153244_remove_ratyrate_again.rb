class RemoveRatyrateAgain < ActiveRecord::Migration
  def change
    if table_exists?(:average_caches)
      drop_table :average_caches
    end
    if table_exists?(:overall_averages)
      drop_table :overall_averages
    end
    if table_exists?(:rates)
      drop_table :rates
    end
    if table_exists?(:rating_caches)
      drop_table :rating_caches
    end
  end
end
