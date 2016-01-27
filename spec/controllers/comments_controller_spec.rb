require "rails_helper"

describe CommentsController, :type => :controller do

	describe "GET #create" do
		before do
			@product = FactoryGirl.create(:product)
			@comment = FactoryGirl.attributes_for(:comment)
		end

		it "should redirect to the product page when not logged in" do
			get :create, product_id: @product.id, comment: @comment
        	expect(response).to redirect_to(new_user_session_path)
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

	describe "DELETE #destroy" do
		before do
			@product = FactoryGirl.create(:product)
			@user = FactoryGirl.create(:user)
			@comment = FactoryGirl.create(:comment, product: @product, user: @user)
		end

		it "should redirect to the product page when not logged in" do
			delete :destroy, product_id: @product.id, id: @comment.id
        	expect(response).to redirect_to(new_user_session_path)
		end

		context "When logged in as a normal user" do
			before do
				sign_in @user
			end

			it "should delete my own comment" do
				delete :destroy, product_id: @product.id, id: @comment.id
	        	expect(response).to redirect_to(@product)
	      		expect(flash[:notice]).to be_present
	      		expect(flash[:alert]).not_to be_present
			end

			it "should fail to delete non-existent comment" do
				delete :destroy, product_id: @product.id, id: -123
	        	expect(response).to redirect_to(products_url)
	      		expect(flash[:notice]).not_to be_present
	      		expect(flash[:alert]).to be_present
			end

			it "should fail to delete comment not owned by me" do
				@user2 = FactoryGirl.create(:user)
				@comment2 = FactoryGirl.create(:comment, product: @product, user: @user2)

				delete :destroy, product_id: @product.id, id: @comment2.id
	        	expect(response).to redirect_to(@product)
	      		expect(flash[:notice]).not_to be_present
	      		expect(flash[:alert]).to be_present
			end
		end

		context "When logged in as an admin user" do
			before do
				@admin = FactoryGirl.create(:admin)
				sign_in @admin
			end

			it "should delete my own comment" do
				@comment_admin = FactoryGirl.create(:comment, product: @product, user: @admin)
				delete :destroy, product_id: @product.id, id: @comment_admin.id
	        	expect(response).to redirect_to(@product)
	      		expect(flash[:notice]).to be_present
	      		expect(flash[:alert]).not_to be_present
			end

			it "should fail to delete non-existent comment" do
				delete :destroy, product_id: @product.id, id: -123
	        	expect(response).to redirect_to(products_url)
	      		expect(flash[:notice]).not_to be_present
	      		expect(flash[:alert]).to be_present
			end

			it "should delete comment not owned by me" do
				delete :destroy, product_id: @product.id, id: @comment.id
	        	expect(response).to redirect_to(@product)
	      		expect(flash[:notice]).to be_present
	      		expect(flash[:alert]).not_to be_present
			end
		end
	end
end