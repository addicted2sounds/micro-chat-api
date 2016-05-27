class ChatSerializer < ActiveModel::Serializer
  attributes :id, :title, :user_ids
end
