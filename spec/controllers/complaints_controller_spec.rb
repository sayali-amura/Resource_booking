	

require 'rails_helper'

RSpec.describe ComplaintsController, type: :controller do
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
		params = {"resource_id"=>"2", "comment"=>"noo"}
  		post :create, complaint: params
  		assert_redirected_to subject.current_employee.complaints.last
	end
	it "renders new on wrong complaint attributes" do
		params = {"resource_id"=>@company.resources.last.id, "comment"=>nil}
		post :create, complaint: params
		expect(response).to render_template("new")
	end
	it "renders new form" do
		get :new
		expect(response).to render_template("new")
	end
	it "renders show form" do
		@complaint = subject.current_employee.complaints.build("resource_id"=>@company.resources.last.id, "comment"=>"noo", "status" => 0,company_id:@company.id)
		a = @complaint.save
		get :show, :id => @complaint.id
		expect(response).to render_template("show")
	end

	it "redirects to the home page upon update" do
		update_params = {"resource_id"=>"1", "comment"=>"not clean"}
		@complaint = subject.current_employee.complaints.build(resource_id:@company.resources.last.id, comment:"noo",status:0,company_id:@company.id)
		@complaint.save
  		patch :update, :id => @complaint.id, complaint: update_params
  		assert_redirected_to complaints_path
	end
	it "redirects to edit on failed update" do
		update_params = {"resource_id"=>"2", "comment"=>nil}
		@complaint = subject.current_employee.complaints.build(resource_id:@company.resources.last.id, comment:"noo",status:0,company_id:@company.id)
		@complaint.save
  		patch :update, :id => @complaint.id, complaint: update_params
  		expect(response).to render_template("edit")
	end
	it "redirects to edit on failed update solved complaint" do
		update_params = {"resource_id"=>@company.resources.last.id, "comment"=>nil,status:0,company_id:@company.id}
		@complaint = subject.current_employee.complaints.build(resource_id:@company.resources.last.id, comment:"noo",company_id:@company.id)
		@complaint.save
		@complaint.status = 1
		a = @complaint.save
  		patch :update, :id => @complaint.id, complaint: update_params
  		expect(response).to render_template("edit")
	end
	# it "checks resource_time_slot" do
	# 	params = {name: @resource.name}
	# 	byebug
	# 	get :resource_time_slot,params
	# 	expect(response.headers["Content-Type"]).to eq "text/javascript; charset=utf-8"
	# end
	it "removes complaint from database" do
		@complaint = subject.current_employee.complaints.build("resource_id"=>@company.resources.last.id, "comment"=>"noo",status:0,company_id:@company.id)
		@complaint.save
		params = {"id"=>"#{@complaint.id}"}
		delete :destroy, params
		assert_redirected_to complaints_path
	end

end

