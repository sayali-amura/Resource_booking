	

require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
	login_employee
	before(:each) do 
    @resource = subject.current_employee.company.resources.last
  	end
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
		params = {"resource_id"=>@resource.id, "comment"=>"conf", "date_of_booking"=>"2016-10-14", "slot"=>"0"}
  		post :create, booking: params
  		assert_redirected_to bookings_path
	end
	it "renders new on wrong booking attributes" do
		params = {"resource_id"=>@resource.id, "comment"=>"conf", "date_of_booking"=>"2016-10-14", "slot"=>123456}
		post :create, booking: params
		expect(response).to render_template("new")
	end
	it "renders new form" do
		get :new
		expect(response).to render_template("new")
	end
	it "renders show form" do
		@booking = subject.current_employee.bookings.build(resource_id:@resource.id, comment:"bdhbc",date_of_booking:"2016-10-15",slot:0)
		@booking.save
		get :show, :id => subject.current_employee.bookings.last.id
		expect(response).to render_template("show")
	end

	it "redirects to the home page upon update" do
		update_params = {"resource_id"=>@resource.id, "comment"=>"conference", "date_of_booking"=>"2016-10-14", "slot"=>"0"}
		@booking = subject.current_employee.bookings.build(resource_id:@resource.id, comment:"bdhbc",date_of_booking:"2016-10-15",slot:0)
		@booking.save
  		patch :update, :id => @booking.id, booking: update_params
  		assert_redirected_to @booking
	end
	it "redirects to edit on failed update" do
		update_params = {"resource_id"=>@resource.id, "comment"=>"conference", "date_of_booking"=>"2016-10-13", "slot"=>nil}
		@booking = subject.current_employee.bookings.build(resource_id:@resource.id, comment:"bdhbc",date_of_booking:"2016-10-15",slot:0)
		@booking.save
  		patch :update, :id => @booking.id, booking: update_params
  		expect(response).to render_template("edit")
	end
	it "redirects to edit on failed update granted booking" do
		update_params = {"resource_id"=>@resource.id, "comment"=>"conference", "date_of_booking"=>"2016-10-13", "slot"=>nil}
		@booking = subject.current_employee.bookings.build(resource_id:@resource.id, comment:"bdhbc",date_of_booking:"2016-10-15",slot:0)
		@booking.save
		@booking.status = 1
		a = @booking.save
  		patch :update, :id => @booking.id, booking: update_params
  		expect(response).to render_template("edit")
	end
	it "removes booking from database" do
		@booking = subject.current_employee.bookings.build(resource_id:@resource.id, comment:"bdhbc",date_of_booking:"2016-10-15",slot:0)
		@booking.save
		params = {"id"=>"#{@booking.id}"}
		delete :destroy, params
		assert_redirected_to bookings_path
	end

end

