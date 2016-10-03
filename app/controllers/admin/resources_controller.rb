class Admin::ResourcesController < ApplicationController
	before_action :find_company
	before_action :find_resource, only: [:show, :edit, :update, :destroy]

	load_and_authorize_resource :resource
	def index
		@resources = @company.resources
	end

	def new
		@resource = @company.resources.build
	end
	
	def create
		@resource = @company.resources.build(resource_params)
		if @resource.save
			flash[:success] = "Resource is successfully created."
			redirect_to ["admin",@resource] 
		else
			render :new
		end
	end
	

	def show; end
	
	def edit; 	end

	def update
		if @resource.update(resource_params)
			flash[:success] = "Resource is successfully updated."
			redirect_to ["admin",@resource]
		else
			render :edit
		end
	end
	
	def destroy
		if @resource.destroy
			if @company.bookings.where(resource_id:params[:id]).destroy_all 
				if @company.complaints.where(resource_id:params[:id]).destroy_all 
					flash[:success] = "Resource, complaints and bookings are destroyed."
					redirect_to admin_dashbord_path
				else
					flash[:error] = "Error while deleting complaints"
				end
			else
				flash[:error] = "Error while deleting bookings"
			end

		else
			flash[:error] = "Error while deleting resource"
		end
		redirect_to request.referer
	end

	private
	
	def resource_params
		params.require(:resource).permit(:name, :company_id,:time_slot)
	end
	
	def find_resource
		@resource = @company.resources.find(params[:id])
	end

end

