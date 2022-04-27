FactoryBot.define do
  factory :survivor do
    name { Faker::Name.name }
    gender { Survivor.genders.values.sample }
    status { Survivor.statuses.keys[0] }

    after(:build) do |survivor, _|
      build(:location_feature, survivor: survivor)
    end

    trait :with_nearest_survivor do
      after(:create) do |obj, _|
        s = create(:survivor) do |near|
          near.location_feature.latitude =
            obj.location_feature.latitude + rand(0.0..0.0009).round(8)
          near.location_feature.longitude =
            obj.location_feature.longitude + rand(0.0..0.0009).round(8)
          near.status = obj.status
          near.nearest_survivor = obj
          near.save
        end

        obj.nearest_survivor = s
        obj.save
      end
    end
  end
end
