FactoryGirl.define do
  factory :chat do
    title { Faker::Lorem.sentence }

    before(:create) do |chat|
      chat.user_ids = create_list(:user, 2).map(&:id)
    end
  end
end
