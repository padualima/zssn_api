class LocationFeature < ApplicationRecord
  # relationships
  belongs_to :survivor
  belongs_to :nearest_survivor, class_name: 'Survivor', foreign_key: :survivor_id, optional: true
end
