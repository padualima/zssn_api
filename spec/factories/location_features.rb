FactoryBot.define do
  factory :location_feature do
    survivor
    nearest_survivor { nil }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
