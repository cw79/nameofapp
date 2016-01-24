class StaticPagesController < ApplicationController

	def index
		@products = Product.limit(5)

		@characteristics = Array.new()
		@bars.each do |id, bar|
			bar.characteristics.each do |character|
				@characteristics.push(character)
			end
		end
		@characteristics = @characteristics.uniq
	end

	def initialize
  		@bars = {
  			1 => Bar.new(1, "100label", "100%", ["unsweetened", "intense", "dark"]),
		  	2 => Bar.new(2, "91label", "91%", ["bitter", "dark", "robust", "smoky", "full"]),
		  	3 => Bar.new(3, "82label", "82%", ["bitter", "dark", "robust", "rich", "full"]),
		  	4 => Bar.new(4, "70label", "70%", ["rich", "fruity", "sweet"]),
		  	5 => Bar.new(5, "48label", "48%", ["rich", "fruity", "sweet", "warm"]),
		  	6 => Bar.new(6, "43label", "43%", ["sweet", "vanilla", "caramel"]),
		  	7 => Bar.new(7, "37label", "37%", ["sweet", "vanilla", "caramel", "toffee", "light"]),
		  	8 => Bar.new(8, "35label", "35%", ["sweet", "vanilla", "white chocolate"])
  		}
  		super
  	end

	def matching_bars
		characteristic = params[:characteristic]

		ids = Array.new()
		@bars.each do |id, bar|
			if (bar.characteristics.include?(characteristic))
				ids.push(id)
			end
		end

		render json: ids
	end

	def landing_page
    	redirect_to "/"
	end

	def thank_you
		@name = params[:name]
		@email = params[:email]
		@message = params[:message]
		ActionMailer::Base.mail(:from => @email,
			:to => 'corie.wiren@gmail.com',
			:subject => "A new contact form message from #{@name}",
			:body => @message).deliver_now
	end
end

	

