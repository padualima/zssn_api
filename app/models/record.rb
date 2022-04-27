class Record < ApplicationRecord
  belongs_to :survivor
  belongs_to :by_survivor, class_name: 'Survivor', optional: true

  # enumerate
  enum kind: %i[infected recovered]

  # validations
  validates :kind, presence: true
end
