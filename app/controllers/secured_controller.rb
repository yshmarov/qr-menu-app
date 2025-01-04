class SecuredController < ApplicationController
  before_action :authenticate

  USERNAME = 'ewlit'.freeze
  PASSWORD = '123456'.freeze

  private

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == USERNAME && password == PASSWORD
    end
  end
end
