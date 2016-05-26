class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  protected

  def authenticate!
    authenticate_or_request_with_http_token do |token|
      User.exists? auth_token: token
    end
  end
end
