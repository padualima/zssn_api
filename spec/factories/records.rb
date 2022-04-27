FactoryBot.define do
  factory :record do
    survivor
    by_survivor { nil }
    kind { Record.kinds.values.sample }
  end
end
