class LocationFeature < ApplicationRecord
  # relationships
  belongs_to :survivor
  belongs_to :nearest_survivor_id, class_name: 'Survivor', optional: true
end
