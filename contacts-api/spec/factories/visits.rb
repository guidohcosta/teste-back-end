FactoryBot.define do
  factory :visit do
    identifier { SecureRandom.uuid }
    url { Faker::Internet.url }
  end
end
