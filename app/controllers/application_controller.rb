class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  attr_reader :current_user

  protected

  def authenticate!
    authenticate_or_request_with_http_token do |token|
      @current_user = User.find_by auth_token: token
    end
  end
end
