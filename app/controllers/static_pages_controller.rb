class StaticPagesController < ApplicationController
	def initialize
  		@bars = {
  			1 => Bar.new(1, "100%", ["unsweetened", "intense", "dark"]),
		  	2 => Bar.new(2, "91%", ["bitter", "dark", "robust", "smoky", "full"]),
		  	3 => Bar.new(3, "82%", ["bitter", "dark", "robust", "rich", "full"]),
		  	4 => Bar.new(4, "70%", ["rich", "fruity", "sweet"]),
		  	5 => Bar.new(5, "48%", ["rich", "fruity", "sweet", "warm"]),
		  	6 => Bar.new(6, "43%", ["sweet", "vanilla", "caramel"]),
		  	7 => Bar.new(7, "37%", ["sweet", "vanilla", "caramel", "toffee", "light"]),
		  	8 => Bar.new(8, "35%", ["sweet", "vanilla", "white chocolate"])
  		}
  		super
  	end

  def index
	  @characteristics = Array.new()
	  @bars.each do |id, bar|
	  	puts "#{id} #{bar.name}"
	  	bar.characteristics.each do |character|
	  		puts character
	  	  	@characteristics.push(character)
	  	end
	  end
	  @characteristics = @characteristics.uniq
  end
end
