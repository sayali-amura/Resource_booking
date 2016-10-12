require 'rails_helper'

RSpec.describe Admin::RolesController, type: :controller do
  login_admin
  context "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  context "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  context "GET #show" do
    it "returns http success" do
      get :show, {id: @company.roles.first.id}
      expect(response).to redirect_to(admin_roles_path)
    end
  end

  context "GET #edit" do
    it "returns http success" do
      get :edit, {id: @company.roles.first.id}
      expect(response).to have_http_status(:success)
    end
  end
end
