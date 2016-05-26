class ChatsController < ApplicationController
  before_action :authenticate!
  before_action :set_chat, only: [:update]

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
    unless @chat.users.exists?(id: current_user.id)
      render nothing: true, status: :unauthorized
      return
    end

    if @chat.update(chat_params)
      render json: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  private

  def set_chat
    @chat = Chat.find params[:id]
  end

  def chat_params
    params.require(:chat).permit(:title, user_ids: [])
  end
end
