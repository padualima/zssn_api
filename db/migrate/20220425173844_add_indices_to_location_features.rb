class AddIndicesToLocationFeatures < ActiveRecord::Migration[7.0]
  def change
    add_index(
      :location_features,
      %i(survivor_id latitude longitude),
      name: 'index_location_features_on_survivor_id_and_location'
    )
  end
end
