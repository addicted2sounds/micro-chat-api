class MessagesController < ApplicationController
  before_action :authenticate!
  before_action :set_chat

  def index
    @messages = Message.where(chat: @chat)
    render json: @messages
  end

  def create
    @message = Message.new message_params
    @message.user = current_user
    @message.chat = @chat
    if @message.save
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def set_chat
    @chat = Chat.find params[:chat_id]
  end
end
