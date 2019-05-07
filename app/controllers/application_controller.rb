class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # Recomended devise way to allow extra prams at user sign up.
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username, :seller, :avatar])
  end
end
