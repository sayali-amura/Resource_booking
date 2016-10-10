module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:employee]
      @company = FactoryGirl.create(:company)
      employee = @company.employees.first
      employee.confirm
      sign_in employee 
      
    end
  end

  def login_employee
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:employee]
      @company = FactoryGirl.create(:company)
      employee = @company.employees.last
      employee.confirm 
      sign_in employee
    end
  end
end
