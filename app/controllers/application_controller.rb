require 'exceptions'
class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  attr_reader :current_user

  rescue_from NotAuthorizedError, with: :not_authorized

  def not_authorized
    render json: { error: 'Not authorized' }, status: :unauthorized
  end

  protected

  def authenticate!
    authenticate_or_request_with_http_token do |token|
      @current_user = User.find_by auth_token: token
    end
  end
end
