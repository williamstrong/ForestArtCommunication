FactoryBot.define do
  factory :message do
    message_body { Faker::Lorem.paragraph }
    subject { Faker::Lorem.words }
    person nil
  end
end
