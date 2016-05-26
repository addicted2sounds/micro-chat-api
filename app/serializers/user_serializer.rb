class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :messages_count, :auth_token, :created_at
end
