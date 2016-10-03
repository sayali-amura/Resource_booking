class ComplaintsController < ApplicationController
  before_action :find_company
  before_action :find_complaint, only: [:show, :edit, :update]
  before_action :list_resources, only: [:new,:edit]
  load_and_authorize_resource :complaint
	def index
		if @company.resources.any?
			@complaints = @company.complaints		
		end
	end
	def new

		if @company.resources.any?
			@complaint = @company.complaints.build
		end

	end
	def create
		if @company.resources.any?
			complaint_param = complaint_params
			complaint_param[:status] = 0

			complaint_param[:employee_id] = current_employee.id
			@complaint = @company.complaints.build(complaint_param)
			if @complaint.save
				redirect_to @complaint 
			else 
				render :new
			end
		end
	end
	def show
		@resource = @company.resources.find(@complaint.resource_id)
	end
	def edit; end
	
	def update
		if @complaint.update(complaint_params)
			redirect_to @complaint
		else
			render :edit
		end
	end
	
	def destroy
		@complaint.destroy
		redirect_to complaints_path
	end

	private

	def complaint_params
		params.require(:complaint).permit(:comment, :resource_id, :employee_id)
	end

	def find_complaint
		@complaint = @company.complaints.find(params[:id])
	end

	def list_resources
		@resources = @company.resources
	end
end