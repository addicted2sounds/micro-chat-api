class UserListSerializer < ActiveModel::Serializer
  attributes :id, :name, :messages_count, :created_at
end
