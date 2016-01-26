require 'rails_helper'

describe User do 

	before do
	end
	
	it "must have an email address" do
		expect(User.new(password: "I don't like user names")).not_to be_valid
	end
	
	it "must have a password" do
		expect(User.new(email: "no@password.com")).not_to be_valid
	end
end


describe User, :type => :model do
  it "should not validate users without an email address" do
    @user = FactoryGirl.build(:user, email: "not_an_email")
    expect(@user).to_not be_valid
  end
end
