FactoryBot.define do
  factory :survivor do
    name { Faker::Name.name }
    gender { Survivor.genders.values.min }
    status { Survivor.statuses.values.min }
  end
end
