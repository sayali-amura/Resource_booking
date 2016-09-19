class ResourcesController < ApplicationController
	layout "_layout",only: [:edit, :new]
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
		@resource = Resource.find(params[:id])
	end
	def edit
		@resource = Resource.find(params[:id])
	end
	def update
		@resource = Resource.find(params[:id])
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
end