class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_request

  private

  def authenticate_request
    api_key = request.headers['api-key']
    @current_tenant = Tenant.find_by(api_key: api_key)

    head :unauthorized unless @current_tenant
  end
end
