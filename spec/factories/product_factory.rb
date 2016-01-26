FactoryGirl.define do
	sequence(:name) { |n| "Chocolate#{n}" }

	factory :product do
		image_url "not_an_url"
		name 
		description "Bean from some far away place. Tastes good. "
		price 6.00

		factory :product_with_comments do
			transient do
				comments_count 3
				comment_user nil
			end

			after(:create) do |product, evaluator|
				create_list(:comment, evaluator.comments_count, product: product, user: evaluator.comment_user)
			end
		end
	end
end