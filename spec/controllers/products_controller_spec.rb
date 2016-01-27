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

      it "should redirect to products page when non-existent product requested" do
        get :show, id: -123
        expect(response).to redirect_to(products_url)
        expect(flash[:notice]).not_to be_present
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "GET #edit" do
    before do
      @product = FactoryGirl.create(:product)
    end

    context "Anonymous user" do
      it "should redirect to login url" do
        get :edit, id: @product.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end    

    context "Normal user" do
      it "should redirect to products index url" do
        @user = FactoryGirl.create(:user)
        sign_in @user
        get :edit, id: @product.id
        expect(response).to redirect_to(products_url)
      end
    end

    context "Admin user" do
      before do
        @admin = FactoryGirl.create(:admin)
        sign_in @admin
      end

      it "should allow editing" do
        get :edit, id: @product.id
        expect(response).to have_http_status(200)
        expect(assigns(:product)).to eq @product
      end

      it "should fail to edit non-existent record" do
        get :edit, id: -123
        expect(response).to redirect_to(products_url)
        expect(flash[:notice]).not_to be_present
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "POST #create" do
    before do
      @product = FactoryGirl.attributes_for(:product)
    end

    context "Anonymous user" do
      it "should redirect to login url" do
        post :create, product: @product
        expect(response).to redirect_to(new_user_session_path)
      end
    end    

    context "Normal user" do
      it "should redirect to products index url" do
        @user = FactoryGirl.create(:user)
        sign_in @user
        post :create, product: @product
        expect(response).to redirect_to(products_url)
      end
    end

    context "Admin user" do
      before do
        @admin = FactoryGirl.create(:admin)
        sign_in @admin
      end

      it "should allow creating" do
        post :create, product: @product
        expect(response).to redirect_to(assigns(:product))
        expect(assigns(:product)).to have_attributes(@product)
      end

      it "should fail to update when price is nil" do
        @product[:price] = nil
        post :create, product: @product
        expect(response).to render_template("new")
        expect(flash[:notice]).not_to be_present
        expect(flash[:alert]).to be_present
      end

      it "should fail to update when price is less than zero" do
        @product[:price] = -1.2
        post :create, product: @product
        expect(response).to render_template("new")
        expect(flash[:notice]).not_to be_present
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "PUT #update" do
    before do
      @product = FactoryGirl.create(:product)
      @product_attributes = @product.attributes
      @product_attributes[:description] = "I changed this!"
    end

    context "Anonymous user" do
      it "should redirect to login url" do
        put :update, id: @product.id, product: @product_attributes
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:notice]).not_to be_present
        expect(flash[:alert]).not_to be_present
      end
    end    

    context "Normal user" do
      it "should redirect to products index url" do
        @user = FactoryGirl.create(:user)
        sign_in @user
        put :update, id: @product.id, product: @product_attributes
        expect(response).to redirect_to(products_url)
        expect(flash[:notice]).not_to be_present
        expect(flash[:alert]).not_to be_present
      end
    end

    context "Admin user" do
      before do
        @admin = FactoryGirl.create(:admin)
        sign_in @admin
      end

      it "should allow update" do
        put :update, id: @product.id, product: @product_attributes
        expect(response).to redirect_to(assigns(:product))
        expect(assigns(:product).description).to eq @product_attributes[:description]
        expect(flash[:notice]).to be_present
        expect(flash[:alert]).not_to be_present
      end

      it "should fail to update non-existent record" do
        put :update, id: -123, product: @product_attributes
        expect(response).to redirect_to(products_url)
        expect(flash[:notice]).not_to be_present
        expect(flash[:alert]).to be_present
      end

      it "should fail to update when price is nil" do
        @product_attributes[:price] = nil
        put :update, id: @product.id, product: @product_attributes
        expect(response).to render_template("edit")
        expect(flash[:notice]).not_to be_present
        expect(flash[:alert]).to be_present
      end

      it "should fail to update when price is less than zero" do
        @product_attributes[:price] = -1.2
        put :update, id: @product.id, product: @product_attributes
        expect(response).to render_template("edit")
        expect(flash[:notice]).not_to be_present
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @product = FactoryGirl.create(:product)
    end

    context "Anonymous user" do
      it "should redirect to login url" do
        delete :destroy, id: @product.id
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:notice]).not_to be_present
        expect(flash[:alert]).not_to be_present
      end
    end    

    context "Normal user" do
      it "should redirect to products index url" do
        @user = FactoryGirl.create(:user)
        sign_in @user
        delete :destroy, id: @product.id
        expect(response).to redirect_to(products_url)
        expect(flash[:notice]).not_to be_present
        expect(flash[:alert]).not_to be_present
      end
    end

    context "Admin user" do
      before do
        @admin = FactoryGirl.create(:admin)
        sign_in @admin
      end

      it "should allow destroying" do
        delete :destroy, id: @product.id
        expect(response).to redirect_to(products_url)
        expect(flash[:notice]).to be_present
        expect(flash[:alert]).not_to be_present
      end

      it "should fail to delete non-existent record" do
        delete :destroy, id: -123
        expect(response).to redirect_to(products_url)
        expect(flash[:notice]).not_to be_present
        expect(flash[:alert]).to be_present
      end
    end
  end
end