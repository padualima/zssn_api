class LocationFeature < ApplicationRecord
  # relationships
  belongs_to :survivor
  belongs_to :nearest_survivor, class_name: 'Survivor', foreign_key: :survivor_id, optional: true

  # validations
  validates :latitude, :longitude, presence: true
  validates :latitude , numericality: { greater_than_or_equal_to:  -90, less_than_or_equal_to:  90 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validate :nearest_survivor_exists?
  # TODO: create helper check in controller for param attribute type

  # custom validations
  def nearest_survivor_exists?
    unless nearest_survivor_id.nil? || Survivor.exists?(id: nearest_survivor_id)
      errors.add(:nearest_survivor_id, 'was not found')
    end
  end
end
