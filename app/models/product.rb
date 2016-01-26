class Product < ActiveRecord::Base
	has_many :orders
	has_many :comments
	validates :name, presence: true
	validates :price, numericality: { only_integer: true }

	def average_rating
		comments.average(:rating).to_f
	end
end
