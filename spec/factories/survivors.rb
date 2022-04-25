FactoryBot.define do
  factory :survivor do
    name { Faker::Name.name }
    gender { Survivor.genders.values.min }
    status { Survivor.statuses.values.min }

    trait :with_location do
      location_feature { association :location_feature, survivor: instance }
    end
  end
end
