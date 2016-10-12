require 'rails_helper'

RSpec.describe CompanyController, type: :controller do
	before(:each) do 
    		@company = create(:company)
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
		params = {"name"=>"facebook", "email"=>"fb@gmail.com", "phone"=>"+919867542398", "start_time"=>"08:00", "end_time"=>"19:00"}
  		post :create, company: params
  		assert_redirected_to company_path(Company.last.id)
	end
	it "renders new on wrong company attributes" do
		params = {"name"=>"facebook", "email"=>"fb.gmail.com.en.pp", "phone"=>"+919867542398", "start_time"=>"08:00", "end_time"=>"19:00"}
		post :create, company: params
		expect(response).to render_template("new")
	end
	it "renders new form" do
		get :new
		expect(response).to render_template("new")
	end
	login_admin
	it "renders show form" do
		get :show, :id => @company.id
		expect(response).to render_template("show")

	end

	it "redirects to the home page upon update" do
		update_params = {"name"=>"facebook", "email"=>"fb@gmail.com", "phone"=>"+919867542398", "start_time"=>"08:00", "end_time"=>"20:00"}
  		patch :update, :id => @company.id, company: update_params

  		assert_redirected_to company_index_path
	end
	it "redirects to edit on failed update" do
		update_params = {"name"=>nil, "email"=>"fb.gmail.com.en.pp", "phone"=>"+919867542398", "start_time"=>"08:00", "end_time"=>"19:00"}
  		patch :update, :id => @company.id, company: update_params
  		expect(response).to render_template("edit")
	end
	# it "removes company from database" do
	# 	byebug
	# 	params = {"id"=>"#{@company.id}"}
	# 	delete :destroy, params
	# 	assert_redirected_to root_path
	# end

end
