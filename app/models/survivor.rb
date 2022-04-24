class Survivor < ApplicationRecord
  # enumerate
  enum gender: %i[masculine feminine neutral]
  enum status: %i[refugee infected recovered]

  # # validations
  validates :name, :gender, :status, presence: true
  validates :gender, inclusion: { in: genders.keys }
  validates :status, inclusion: { in: statuses.keys }
end
