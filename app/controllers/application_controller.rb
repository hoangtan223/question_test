class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_request

  attr_reader :current_tenant

  private

  def authenticate_request
    api_key = request.headers['api-key']
    @current_tenant = Tenant.find_by(api_key: api_key)

    if @current_tenant
      current_tenant.update(api_call_count: current_tenant.api_call_count + 1)
    else
      head :unauthorized
    end
  end
end
