class ChatsController < ApplicationController
  before_action :authenticate!

  def index
    @chats = Chat.joins(:chat_users)
                 .where(chat_users: { user_id: current_user.id }).all
    render json: @chats
  end

  def create
    chat = Chat.new chat_params
    if chat.save
      render json: chat
    else
      render json: chat.errors, status: :unprocessable_entity
    end
  end

  def update
  end

  private

  def chat_params
    params.require(:chat).permit(:title, user_ids: [])
  end
end
