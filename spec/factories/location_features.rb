FactoryBot.define do
  factory :location_feature do
    survivor
    nearest_survivor { nil }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }

    trait :with_survivor_nearby do
      after(:build) do |obj|
        build(:location_feature) do |nearest|
          nearest.latitude = obj.latitude + rand(0.0..0.0009).round(8)
          nearest.longitude = obj.longitude + rand(0.0..0.0009).round(8)
          nearest.save
        end
      end
    end
  end
end
