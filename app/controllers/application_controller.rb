class ApplicationController < ActionController::Base
  before_action :basic_authentication if Rails.env.production?

  private

  def basic_authentication
    authenticate_or_request_with_http_basic do |name, password|
      name == "dic" && password == "P@ssw0rd!"
    end
  end
end
