class Product < ActiveRecord::Base
	has_many :orders
	has_many :comments
	validates :name, presence: true
	validates :price, presence: true, numericality: { greater_than: 0 }

	def average_rating
		comments.average(:rating).to_f
	end
end
