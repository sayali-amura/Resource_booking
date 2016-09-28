class Admin::RolesController < ApplicationController
	before_action :find_company, :verify_user
	before_action :find_role, only: [:edit, :show]
  def index
  end

  def new
  	@role = Role.new
  end

  def create
  	@role = @company.roles.new(role_params)
  	if @role.save
  		redirect_to ["admin",@role]
  	else
  		render :new
  	end
  end

  def show
  	
  end

  def edit
  	
  end

  private
  def role_params
  	params.require(:role).permit(:designation,:department,:priority)
  end

  def find_role
  	@role = @company.roles.find(params[:id])
  end

  def verify_user
    unless current_employee.id == session["warden.user.employee.key"][0][0] && current_employee.role_id == 0
      flash[:alert] << "You dont't have privilage to add resources" 
      redirect_to request.referer
    end
  end
  
  def find_company
    if employee_signed_in?
      @company = current_employee.company
    else
      redirect_to root_path
    end
  end

end
