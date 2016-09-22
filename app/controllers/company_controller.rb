class CompanyController < ApplicationController
	def index

	end
	def new
		@company = Company.new
	end

	def create
		@company = Company.new(company_params)
		if @company.save
			@role = Role.new(designation: "Admin",department: @company.name,priority: 0 )
			@employee = @company.employees.new(name: "Admin",email: "admin@#{@company.name}.com",age:22,date_of_joining: Date.today,
									 manager_id: 0,role_id: 0,password:123456,password_confirmation: 123456)
			if !(@employee.save && @role.save)
				flash[:alert] = "There is error while adding default user to company account"
				render new_company_path
			else
				redirect_to @company
			end
			
		else
			render :new
		end
	end

	def show
		@company = Company.find(params[:id])
	end
	private
	def company_params
		params.require(:company).permit(:name,:email,:phone,:start_time,:end_time)
	end
end
