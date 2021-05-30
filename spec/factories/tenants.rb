FactoryBot.define do
  factory :tenant do
    name { Faker::Name.name }
    api_key { Faker::Internet.password }
  end
end
