class LocationFeature < ApplicationRecord
  attr_accessor :address

  reverse_geocoded_by :latitude, :longitude

  # relationships
  belongs_to :survivor
  belongs_to :nearest_survivor, class_name: 'Survivor', foreign_key: :survivor_id, optional: true

  #callbacks
  after_validation :reverse_geocode,
                   if: -> { latitude_changed? || longitude_changed? }

  # validations
  validates :latitude, :longitude, presence: true
  validates :latitude,
            numericality: { greater_than_or_equal_to:  -90, less_than_or_equal_to:  90 }
  validates :longitude,
            numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validate :nearest_survivor_exists?
  # TODO: create helper check in controller for param attribute type

  # scopes
  scope :by_nearby, -> (current) do
    near(current.location, 2, units: :km).where.not(id: current.id)
  end

  # custom validations
  def nearest_survivor_exists?
    unless nearest_survivor_id.nil? || Survivor.exists?(id: nearest_survivor_id)
      errors.add(:nearest_survivor_id, 'was not found')
    end
  end

  def location
    values_at(:latitude, :longitude)
  end
end
