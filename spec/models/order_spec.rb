require 'rails_helper'

describe Order do 

	before do
		@product = FactoryGirl.create(:product)
		@user = FactoryGirl.create(:user)
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