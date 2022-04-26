class Survivor < ApplicationRecord
  # relationships
  has_one :location_feature, dependent: :destroy
  accepts_nested_attributes_for :location_feature, update_only: true

  delegate :location, to: :location_feature

  # enumerate
  enum gender: %i[masculine feminine neutral]
  enum status: %i[refugee infected recovered]

  # validations
  validates :name, :gender, :status, presence: true
  validates :gender, inclusion: { in: genders.keys }
  validates :status, inclusion: { in: statuses.keys }
  validate  :is_location_present?

  def is_location_present?
    errors.add(:location, "can't be blank") unless location_feature.present?
  end

  # The State Machine
  include AASM

  aasm :status, column: :status, enum: true do
    state :refugee, initial: true # survivor starts as a refugee
    state :infected # survivor has been infected
    state :recovered # survivor was rescued

    event :infect do
      transitions from: :refugee, to: :infected # TODO: guard, when you have three records
    end

    event :redeem do
      transitions from: :refugee, to: :recovered # TODO: guard, when have record
    end
  end
end
