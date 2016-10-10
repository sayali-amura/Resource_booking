	

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
	it "redirects to the home page upon update" do
		update_params = {"name"=>"sayali", "email"=>"sayalip@gmail.com", "manager_id"=>"1", "role_id"=>"2", "age"=>"22", "date_of_joining"=>"2014-11-30"}
		@employee = Employee.last
  		patch :update, :id => @employee.id, employee: update_params
  		assert_redirected_to admin_employees_path
	end
	it "redirect to dashbord" do
		get :dashbord
		expect(response).to render_template("dashbord")
	end
	it "change status of booking" do
		resource = subject.current_employee.company.resources.sample
		@booking = subject.current_employee.bookings.create(resource_id: resource.id, comment: "conference", date_of_booking: Date.tomorrow, slot:0)
		params = {"booking_id"=>@booking.id, "commit"=>"Grant"}
		post :change_status, status: params
		assert_redirected_to admin_dashbord_path
	end

end

