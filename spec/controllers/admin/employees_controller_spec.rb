	

require 'rails_helper'

RSpec.describe Admin::EmployeesController, type: :controller do
	login_admin
	it "should have a current_employee" do
    expect(subject.current_employee).to_not eq(nil)
  	end
	describe "GET #index" do
		it "renders the index template" do
	    	get 'index'
    		expect(response).to render_template("index")
	    end
	    # it "assigns @employees" do 
	    # end

	end
	it "redirects to the home page upon save" do
		params = {"name"=>"hello", "email"=>"sayali@123.com", "manager_id"=>2, "role_id"=>2, "age"=>23, "date_of_joining"=>"2016-12-03"}
  		post :create, employee: params
  		assert_redirected_to admin_employees_path
	end
	end
end

