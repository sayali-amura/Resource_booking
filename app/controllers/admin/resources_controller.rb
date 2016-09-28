class Admin::ResourcesController < ApplicationController
	#layout "_layout",only: [:edit, :new]
	before_action :find_company,:verify_user
	before_action :find_resource, only: [:show, :edit, :update]

	def index
		@resources = Resource.all
		
	end

	def new
		@resource = Resource.new
	end
	
	def create
		@company = current_employee.company
		@resource = @company.resources.new(resource_params)
		if @resource.save
			redirect_to ["admin",@resource] 
		else 
			render :new
		end
	end
	
	def show
			
	end
	
	def edit
		
	end
	
	def update
		if @resource.update(resource_params)
			redirect_to ["admin",@resource]
		else
			render :edit
		end
	end
	private
	def resource_params
		params.require(:resource).permit(:name, :count, :company_id,:time_slot)
	end
	def find_resource
		@resource = @company.resources.find(params[:id])
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

