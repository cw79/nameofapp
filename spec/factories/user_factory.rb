FactoryGirl.define do
	sequence(:email) { |n| "user#{n}@example.com" }
	
	factory :user do
		email 
		password "123456789"
		first_name "Test"
		last_name "Example"
		admin false
	end

	factory :admin, class: User do
  		email 
  		password "123456789"
  		first_name "Admin"
  		last_name "User"
  		admin true
	end
end