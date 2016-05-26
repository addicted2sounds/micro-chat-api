FactoryGirl.define do
  factory :message do
    body { Faker::Lorem.sentence }
    user
    chat
  end
end
