class Chat < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
end
