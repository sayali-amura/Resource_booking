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

  # def give_id(company_id)
  #   resources = Resource.where(company_id:company_id)
  #   @id_array = []
  #   resources.each do |res|
  #     @id_array << res.id 
  #   end
  #   @id_array
  # end
  
  def find_company
    # if employee_signed_in? 
      @company = current_employee.company
    # end
  end

  def find_employee
    # if employee_signed_in?
    @employee = current_employee
    # else
    #   redirect_to new_employee_session
    # end
  end

  # def admin?
  #   find_company
  #   if current_employee.email != "admin@#{@company.name}.com"
  #     redirect_to root_path
  #   end
  # end

end
