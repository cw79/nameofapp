require 'rails_helper'

describe Comment do 

	before do
		@product = Product.create!(name: "peru")
		@user = User.create!(email: "foo@bar.com", password: "abcd1234!")
	end
	
	it "must have a body" do
		expect(@product.comments.build(rating: 1, user: @user, body: nil)).not_to be_valid
	end

	it "must have a user" do
		expect(@product.comments.build(rating: 1, user: nil, body: "Blah")).not_to be_valid
	end

	it "must have a rating" do
		expect(@product.comments.build(rating: nil, user: @user, body: "Blah")).not_to be_valid
	end

	it "must have a numerical rating" do
		expect(@product.comments.build(rating: "a", user: @user, body: "Blah")).not_to be_valid
	end

end