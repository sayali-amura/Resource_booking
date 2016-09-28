class Admin::RolesController < ApplicationController
	before_action :find_company
	before_action :find_role, only: [:edit, :show]
  before_action :admin?
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

  def find_company
  	@company = current_employee.company
  end
end
