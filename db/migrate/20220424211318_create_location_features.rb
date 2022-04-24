class CreateLocationFeatures < ActiveRecord::Migration[7.0]
  def change
    create_table :location_features do |t|
      t.references :survivor, null: false, foreign_key: true
      t.belongs_to :nearest_survivor_id, null: true, index: true
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.timestamps
    end
  end
end
