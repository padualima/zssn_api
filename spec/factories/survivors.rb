FactoryBot.define do
  factory :survivor do
    name { Faker::Name.name }
    gender { Survivor.genders.values.min }
    status { Survivor.statuses.values.min }

    after(:build) do |survivor, _|
      build(:location_feature, survivor: survivor)
    end
  end
end
