require "rails_helper"

describe UsersController, :type => :controller do
  
  before do
    @user = User.create(:email=>"foo1@bar.com", :password=>"123456789")
    @user2 = User.create(:email=>"foo2@bar.com", :password=>"123456789")
  end

  describe "GET #show" do
    context "User is logged in" do
      before do
        sign_in @user

      end
      
      it "loads correct user details" do
      get :show, id: @user.id
      expect(response).to have_http_status(200) 
      expect(assigns(:user)).to eq @user
      end

    end

    context "No user is logged in" do
      it "redirects to login" do
        get :show, id: @user.id
        expect(response).to redirect_to(root_path)
      end

    end

    context "One user tries to access another users account" do
      
      it "redirects to login" do
        get :show, id: @user.id
        expect(response).to redirect_to(root_path)

      end

      it 'responds with HTTP 302 redirect code' do
        get :show, id: @user.id
        expect(response).to have_http_status(302)
      end

    end
  end
end