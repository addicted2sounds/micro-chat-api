class ChatsController < ApplicationController
  before_action :authenticate!

  def index
    @chats = Chat.joins(:chat_users).all
    render json: @chats
  end

  def create
  end

  def update
  end
end
