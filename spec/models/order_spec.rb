require 'rails_helper'

describe Order do 

	before do
		@product = Product.create!(name: "peru")
		@user = User.create!(email: "foo@bar.com", password: "abcd1234!")
	end
	
	it "must have a product" do
		expect(Order.new(product: nil, user: @user, total: 2)).not_to be_valid
	end
	
	it "must have a user" do
		expect(Order.new(product: @product, user: nil, total: 2)).not_to be_valid
	end
	
	it "must have a total amount" do
		expect(Order.new(product: @product, user: @user, total: nil)).not_to be_valid
	end
	
	it "must have a numerical total amount" do
		expect(Order.new(product: @product, user: @user, total: "alot")).not_to be_valid
	end
end