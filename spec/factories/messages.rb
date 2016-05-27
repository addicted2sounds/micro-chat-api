FactoryGirl.define do
  factory :message do
    body { Faker::Lorem.sentence }
    user
    chat

    after(:create) do |message|
      FactoryGirl.create(
        :chat_user, user: message.user, chat: message.chat
      )
    end
  end
end
