class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  protected

  def authenticate
     User.find_by(api_key: params[:token].to_s).present? ? true : authenticate_or_request_with_http_token
  end
end
