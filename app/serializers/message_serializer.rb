class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :user_id, :chat_id
end
