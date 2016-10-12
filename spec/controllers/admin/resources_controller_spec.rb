require 'rails_helper'

RSpec.describe Admin::ResourcesController, type: :controller do

  login_admin
  before(:each) do
    @resource = @company.resources.last
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
    params = {"name"=>"projector", "time_slot"=>"00:30"}
      post :create, resource: params
      assert_redirected_to admin_resources_path
  end
  it "renders new on wrong resource attributes" do
    params = {"name"=>"projector", "time_slot"=>nil}
    post :create, resource: params
    expect(response).to render_template("new")
  end
  it "renders new form" do
    get :new
    expect(response).to render_template("new")
  end
  it "renders show form" do
    get :show, :id => @resource.id
    assert_redirected_to admin_resources_path
  end


  it "redirects to the home page upon update" do
      update_params = {"name"=>"projector", "time_slot"=>"1:00"}
      patch :update, :id => @resource.id, resource: update_params
      assert_redirected_to admin_resources_path
  end
  it "redirects to edit on failed update" do
      update_params = {"name"=>"projector", "time_slot"=>nil}
      patch :update, :id => @resource.id, resource: update_params
      expect(response).to render_template("edit")
  end
  
  it "removes resource from database" do
    params = {"id"=>"#{@resource.id}"}
    delete :destroy, params
    assert_redirected_to admin_resources_path
  end


end
