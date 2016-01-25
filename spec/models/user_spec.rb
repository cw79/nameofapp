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