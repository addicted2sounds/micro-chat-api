class UnreadMessagesController < ApplicationController
  before_action :authenticate!
  before_action :set_chat
  before_action :set_message, except: [:index]
  before_action :authorize_chat!

  def index
    render json: @chat.unread_messages(current_user)
  end

  def destroy
    @message.set_last_read!(current_user)
    render nothing: true, status: :ok
  end

  private

  def set_message
    @message = @chat.messages.find params[:id]
  end

  def set_chat
    @chat = Chat.find params[:chat_id]
  end

  def authorize_chat!
    unless @chat.chat_users.exists? user_id: current_user.id
      raise NotAuthorizedError
    end
  end
end
