class StaticPagesController < ApplicationController
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

  def index
	  @characteristics = Array.new()
	  @bars.each do |id, bar|
	  	bar.characteristics.each do |character|
	  	  	@characteristics.push(character)
	  	end
	  end
	  @characteristics = @characteristics.uniq
  end
end
