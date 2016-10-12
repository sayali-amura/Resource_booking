#
# Class ComplaintsController provides CRUD operations for complaints
#
# @author Amrut Jadhav amrut@amuratech.com
#
class ComplaintsController < ApplicationController

	# before_filter
  	before_action :find_company
  	before_action :find_complaint, only: [:show, :edit, :update]
  	before_action :list_resources, only: [:new,:edit]

	# Authorize employee
	# @raise [CanCan::AccessDenied] if the user does not have permission
  	load_and_authorize_resource :complaint
	
	#
	# Display all complaints of company if any
	#
	#
	# @return initialize @complaints if company has resources
	# 
	def index
			@complaints = @company.complaints
	end

	# 
	# Build a new complaint object for form if company has resources
	#
	# @return Build resource object
	# 
	def new
		if @company.resources.any?
			@complaint = @company.complaints.build
		end
	end
	
	#
	# Create a new complaint
	# (see #complaint_params)
	#
	# @return [<type>] <description>
	# 
	def create
		if @company.resources.any?
			complaint_param = complaint_params
			complaint_param[:status] = 0
			complaint_param[:employee_id] = current_employee.id
			@complaint = @company.complaints.build(complaint_param)
			if @complaint.save
				flash[:success] = "Complaint is successfully created"
				redirect_to @complaint 
			else 
				flash[:danger] = "Error while deleting complaint"
				render :new
			end
		end
	end

	#
	# Show info of complaint corresponding to id
	# @param [Hash] params The params from post request	
	# @option params [Integer] id Id of complaint
	# @return @resource object
	# 
	def show
		@resource = @company.resources.find(@complaint.resource_id)
	end

	def edit; end
	
	#
	# Update complaint
	# (see #complaint_params)
	# @option params [Integer] id Id of complaint
	#
	# @return [void] redirect_to complaint index if updation is successful else redirect to new
	# 
	def update
		if @complaint.update(complaint_params)
			flash[:success] = "Updation is successful"
			redirect_to complaints_path
		else
			flash[:danger] = "Error while updating complaint"
			render :edit
		end
	end
	
	#
	# Destroy complaint of particular id
	# @param [Hash] params The params from delete request
	#
	# @return redirect_to complaint index page.
	# 
	def destroy
		if @complaint.destroy
			flash[:success] = "Complaint is successfully deleted"
		else
			flash[:danger] = "Error while deleting complaint"
		end
		redirect_to complaints_path
	end

	private

	#
	# Allowing strong parameters
	# @param [Hash] params The params from post request	
	# @option params [String] comment Comment of complaint
	# @option params [Integer] resource_id Id of resource
	# @option params [Integer] employee_id Id of employee 
	#
	#
	# @return [Hash] Strong parameters hash
	# 
	def complaint_params
		params.require(:complaint).permit(:comment, :resource_id, :employee_id)
	end

	#
	# Find a particular complaint
	# @param [Hash] params The params from request
	# @option params [Integer] id Id of complaint
	# 
	# @return @complaint object corresponding to particular id
	# 
	def find_complaint
		@complaint = @company.complaints.find(params[:id])
	end

	#
	# List down the resources of company. 
	#  This method is called after find_company so that @company will set to company of current employee
	#
	# @return [Array<String>] @resources Array of resources of company
	# 
	def list_resources
		@resources = @company.resources
	end
end