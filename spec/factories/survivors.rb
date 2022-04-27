FactoryBot.define do
  factory :survivor do
    name { Faker::Name.name }
    gender { Survivor.genders.values.sample }
    status { Survivor.statuses.values.sample }

    after(:build) do |survivor, _|
      build(:location_feature, survivor: survivor)
    end
  end
end
