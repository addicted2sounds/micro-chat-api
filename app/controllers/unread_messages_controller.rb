class UnreadMessagesController < ApplicationController
  before_action :authenticate!
  before_action :set_chat
  before_action :authorize_chat!

  def index

  end

  def destroy

  end

  private

  def set_chat
    @chat = Chat.find params[:chat_id]
  end

  def authorize_chat!
    unless @chat.chat_users.exists? user_id: current_user.id
      raise NotAuthorizedError
    end
  end
end
