class ComplaintsController < ApplicationController
  before_action :find_complaint, only: [:show, :edit, :update]
  before_action :list_resources, only: [:new,:edit]
	def index
		@complaints = Complaint.all
		
	end
	def new
		@complaint = Complaint.new


	end
	def create
		complaint_param = complaint_params
		complaint_param[:status] = 0

		#add employee id to complaint_param after devise setup
		complaint_param[:employee_id] = current_employee.id
		@complaint = Complaint.new(complaint_param)
		if @complaint.save
			redirect_to @complaint 
		else 
			render :new
		end
	end
	def show
		@resource = Resource.find(@complaint.resource_id)
	end
	def edit; end
	def update
		if @complaint.update(complaint_params)
			redirect_to @complaint
		else
			render :edit
		end
	end
	private
	def complaint_params
		params.require(:complaint).permit(:comment, :resource_id, :employee_id)
	end
	def find_complaint
		@complaint = Complaint.find(params[:id])
		@resources = Resource.all
	end
	def list_resources
		@resources = Resource.all
		end
end