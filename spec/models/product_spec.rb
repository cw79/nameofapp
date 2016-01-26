require 'rails_helper'

describe Product do 

	before do
		@product = FactoryGirl.create(:product)
		@user = FactoryGirl.create(:user)
		@product.comments.create!(rating: 1, user: @user, body: "Ewww!")
		@product.comments.create!(rating: 3, user: @user, body: "Meh...")
		@product.comments.create!(rating: 5, user: @user, body: "Wow!!")
	end
	
	it "returns the average rating of all comments" do
		expect(@product.average_rating).to eq 3
	end

	it "should be invalid when no name is provided" do
		expect(Product.new(description: "Yummy chocolate")).not_to be_valid
	end
end