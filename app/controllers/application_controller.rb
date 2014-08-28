class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to wikis_path, alert: exception.message
  end

  def after_sign_in_path_for(resource)
    wikis_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << :is_premium_user
  end
end
