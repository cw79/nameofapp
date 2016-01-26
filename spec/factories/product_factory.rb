FactoryGirl.define do
sequence(:name) { |n| "Chocolate#{n}" }

	factory :product do
		image_url "not_an_url"
		name 
		description "Bean from some far away place. Tastes good. "
		price "6"
	end
end