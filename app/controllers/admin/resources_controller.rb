class Admin::ResourcesController < ApplicationController
	#layout "_layout",only: [:edit, :new]
	before_action :find_company, only: [:create]
	before_action :find_resource, only: [:show, :edit, :update]
	#before_action :admin?
	load_and_authorize_resource :resource
	def index
		@resources = Resource.where(company_id:current_employee.company_id)
		
	end
	def new
		@resource = Resource.new
	end
	def create
		
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
	def destroy
		Resource.destroy(params[:id])
		redirect_to admin_dashbord_path
	end
	private
	def resource_params
		params.require(:resource).permit(:name, :count, :company_id,:time_slot)
	end
	def find_company
		@company = Company.find(current_employee.company_id)
	end
	def find_resource
		find_company
		@resource = @company.resources.find(params[:id])
	end
end
