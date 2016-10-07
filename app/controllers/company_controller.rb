	#
	# Class CompanyController provides CRUD operations to company object
	#
	# @author Amrut Jadhav amrut@amuratech.com	
	#
	class CompanyController < ApplicationController
		# Filter skip authentication of employee before actions
		skip_before_action :authenticate_employee!, only: [:new, :create, :show]
	
	#
	# Index page
	#
	def index;	end
	
	#
	# Company object built for the company new form
	# 
	def new
		@company = Company.new
	end

	# Create company in database
	# (see #company_params)
	# @return redirect to company object if creation is successful else redirect to new
	# 
	def create
		@company = Company.new(company_params)
		if @company.save
			redirect_to @company
		else
			render :new
		end
	end

	#
	# Destroy company of particular id
	# @param [Hash] params The params from delete request
	#
	# @return redirect_to root
	# 
	def destroy
		@company = Company.find(params[:id])
		if @company.destroy
			flash[:success] = "Company has been successfully deleted"
		else
			flash[:danger] = "Error while deleting company"
		end
		redirect_to root_path
	end

	#
	# Display company of particular id
	# @param [Hash] params The params from get request
	# @option params [Integer] id Id of company
	#
	# @return [Company] @company Company object
	# 
	def show
		@company = Company.find(params[:id])
	end

	private

	#
	# Allowing strong parameters
	# @param [Hash] params The params from post request	
	# @option params [String] name Name of company
	# @option params [String] email Email of company
	# @option params [String] phone Phone of company
	# @option params [Time] start_time Start time of company 
	#
	#
	# @return [Hash] Strong parameters hash
	# 
	def company_params
		# byebug
		params.require(:company).permit(:name,:email,:phone,:start_time,:end_time)
	end

end
