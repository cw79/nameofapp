require "rails_helper"

describe CommentsController, :type => :controller do

	describe "GET #create" do
		before do
			@product = FactoryGirl.create(:product)
			@comment = FactoryGirl.attributes_for(:comment)
		end

		it "should redirect to the product page when not logged in" do
			get :create, product_id: @product.id, comment: @comment
        	expect(response).to redirect_to(root_url)
		end

		context "When logged in" do
			before do
				@user = FactoryGirl.create(:user)
				sign_in @user
			end

			it "should create the comment" do
				get :create, product_id: @product.id, comment: @comment, user_id: @user.id
	        	expect(response).to redirect_to(@product)
	      		expect(assigns(:comment).user).to eq @user
	      		expect(flash[:notice]).to be_present
	      		expect(flash[:alert]).not_to be_present
			end

			it "should fail to create the comment when rating is not sent" do
				@comment[:rating] = nil;
				get :create, product_id: @product.id, comment: @comment, user_id: @user.id
	        	expect(response).to redirect_to(@product)
	      		expect(assigns(:comment).user).to eq @user
	      		expect(flash[:notice]).not_to be_present
	      		expect(flash[:alert]).to be_present
			end

			it "should fail to create the comment when body is not sent" do
				@comment[:body] = nil;
				get :create, product_id: @product.id, comment: @comment, user_id: @user.id
	        	expect(response).to redirect_to(@product)
	      		expect(assigns(:comment).user).to eq @user
	      		expect(flash[:notice]).not_to be_present
	      		expect(flash[:alert]).to be_present
			end
		end
	end
end