class RenameColumnNearestSurvivorIdToLocationFeatures < ActiveRecord::Migration[7.0]
  def change
    rename_column :location_features, :nearest_survivor_id_id, :nearest_survivor_id
  end
end
