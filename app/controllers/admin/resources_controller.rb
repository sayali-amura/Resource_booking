class Admin::ResourcesController < ApplicationController
	#layout "_layout",only: [:edit, :new]
	before_action :find_resource, only: [:show, :edit, :update]

	def index
		@resources = Resource.where(company_id:current_employee.company_id)
		
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
		@resource = Resource.find(params[:id])
	end
end
