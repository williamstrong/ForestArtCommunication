FactoryBot.define do
  factory :person do
    first_name { Faker::Lorem.word }
    last_name { Faker::Lorem.word }
    email { Faker::Lorem.word }
  end
end
