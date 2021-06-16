# frozen_string_literal: false

# application controller
class ApplicationController < ActionController::Base
  include QuestionsHelper
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = %i[name email password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = exception.message
    redirect_to root_url
  end
end
