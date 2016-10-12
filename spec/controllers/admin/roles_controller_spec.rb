require 'rails_helper'

RSpec.describe Admin::RolesController, type: :controller do

  login_admin
  before(:each) do
    @role = @company.roles.last
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
    params = {"designation"=>"founder", "department"=>"amura", "priority"=>"3"}
      post :create, role: params
      assert_redirected_to admin_roles_path
  end
  # it "renders new on wrong employee attributes" do
  #   byebug
  #   params = {"designation"=>"founder", "department"=>"amura", "priority"=>"1"}
  #   post :create, employee: params
  #   expect(response).to render_template("new")
  # end
  it "renders new form" do
    get :new
    expect(response).to render_template("new")
  end
  # it "renders show form" do
  #   get :show, :id => subject.current_employee.id
  #   assert_redirected_to admin_employees_path
  # end


  it "redirects to the home page upon update" do
      update_params = {"name"=>"sayali", "email"=>"sayalip@gmail.com", "manager_id"=>"1", "role_id"=>"2", "age"=>"22", "date_of_joining"=>"2014-11-30"}
      patch :update, :id => @role.id, role: update_params
      assert_redirected_to admin_roles_path
  end
  # it "redirects to edit on failed update" do
  #     update_params = {"name"=>nil  , "email"=>"sayalip@gmail.com", "manager_id"=>"1", "role_id"=>"2", "age"=>"22", "date_of_joining"=>"2014-11-30"}
  #     patch :update, :id => @role.id, role: update_params
  #     expect(response).to render_template("edit")
  # end
  
  it "removes role from database" do
    params = {"id"=>"#{@role.id}"}
    delete :destroy, params
    assert_redirected_to admin_roles_path
  end


end
