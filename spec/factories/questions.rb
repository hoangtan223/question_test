FactoryBot.define do
  factory :question do
    private { false }
    title { Faker::Lorem.sentence }
    user
  end
end
