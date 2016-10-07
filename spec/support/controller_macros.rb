# module ControllerMacros
#   def login_admin
#     before(:each) do
#       @request.env["devise.mapping"] = Devise.mappings[:admin]
#       @company = FactoryGirl.create(:company)
#       sign_in @company.employees.first # Using factory girl as an example
#     end
#   end

#   def login_employee
#     before(:each) do
#       @request.env["devise.mapping"] = Devise.mappings[:employee]
#       @company = FactoryGirl.create(:company)
#       employee = @company.employees.last
#       employee.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
#       sign_in employee
#     end
#   end
# end