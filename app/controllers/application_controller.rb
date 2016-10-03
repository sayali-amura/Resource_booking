class ApplicationController < ActionController::Base
  include Admin::ResourcesHelper
  
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_employee!
  def current_ability
  @current_ability ||= Ability.new(current_employee)
  end
  # check_authorization
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
  
  def find_company
      @company = current_employee.company
  end

  def find_employee
    @employee = current_employee
  end
end
