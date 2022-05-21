class SecuredController < ApplicationController
  before_action :authenticate

  private

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == 'ewlit' && password == '123456'
    end
  end
end
