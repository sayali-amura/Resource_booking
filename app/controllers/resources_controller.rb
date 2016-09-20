class ResourcesController < ApplicationController
	#layout "_layout",only: [:edit, :new]
	before_action :find_resource, only: [:show, :edit, :update]

	def index
		@resources = Resource.all
	end
	def new
		@resource = Resource.new
	end
	def create
		@resource = Resource.new(resource_params)
		if @resource.save
			redirect_to @resource 
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
			redirect_to @resource
		else
			render :edit
		end
	end
	private
	def resource_params
		params.require(:resource).permit(:name, :count, :company_id)
	end
	def find_resource
		@resource = Resource.find(params[:id])
	end
end