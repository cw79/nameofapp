require "rails_helper"

describe ProductsController, :type => :controller do
  
  describe "GET #index" do
    it "shows all products" do
      @products = FactoryGirl.create_list(:product, 5)
      get :index
      expect(response).to have_http_status(200)
      expect(assigns(:products)).to match_array(@products)
    end
  end

  describe "GET #index?search" do

    before do
      @peruDark = FactoryGirl.create(:product, description: "Peruvian dark chocolate")
      @peruLight = FactoryGirl.create(:product, description: "Peruvian light chocolate")
      @swiss = FactoryGirl.create(:product, description: "Swiss chocolate")
    end

    it "finds Peruvian bars" do
      get :index, q: "peru"
      expect(response).to have_http_status(200)
      expect(assigns(:products)).to contain_exactly(@peruDark, @peruLight)
    end

    it "finds the Swiss bar" do
      get :index, q: "swiss"
      expect(response).to have_http_status(200)
      expect(assigns(:products)).to contain_exactly(@swiss)
    end

    it "finds nothing" do
      get :index, q: "milk"
      expect(response).to have_http_status(200)
      expect(assigns(:products)).to contain_exactly()
    end

  end

  describe "GET #show" do
    before do
      @user = FactoryGirl.create(:user)
      @product = FactoryGirl.create(:product_with_comments, comments_count: 11, comment_user: @user)
    end

    context "Browsing comments for a product" do

      it "should show five comments in the first page" do
        get :show, id: @product.id
        expect(response).to have_http_status(200)
        expect(assigns(:product)).to eq @product
        # reverse because they are fetched DESC
        expect(assigns(:comments)).to match_array(@product.comments.reverse.slice(0,5))
      end

      it "should show the next five comments on page two" do
        get :show, id: @product.id, page: 2
        expect(response).to have_http_status(200)
        expect(assigns(:product)).to eq @product
        # reverse because they are fetched DESC
        expect(assigns(:comments)).to match_array(@product.comments.reverse.slice(5,5))
      end

      it "should show only one comment on page three" do
        get :show, id: @product.id, page: 3
        expect(response).to have_http_status(200)
        expect(assigns(:product)).to eq @product
        # just the first one, not-reversed
        expect(assigns(:comments)).to match_array(@product.comments.slice(0,1))
      end
    end
  end

  describe "GET #edit" do
    before do
      @product = FactoryGirl.create(:product)
    end

    context "Anonymous user" do
      it "should redirect to root url" do
        get :edit, id: @product.id
        expect(response).to redirect_to(root_path)
      end
    end    

    context "Normal user" do
      it "should redirect to root url" do
        @user = FactoryGirl.create(:user)
        sign_in @user
        get :edit, id: @product.id
        expect(response).to redirect_to(root_path)
      end
    end

    context "Admin user" do
      it "should allow editing" do
        @admin = FactoryGirl.create(:admin)
        sign_in @admin
        get :edit, id: @product.id
        expect(response).to have_http_status(200)
        expect(assigns(:product)).to eq @product
      end
    end
  end
end