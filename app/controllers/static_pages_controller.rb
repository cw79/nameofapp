class StaticPagesController < ApplicationController
	def initialize
  		@bars = {
  			1 => Bar.new(1, "100%", ["unsweetened", "intense", "dark"]),
		  	2 => Bar.new(2, "91%", ["bitter", "dark", "robust", "smoky", "full"])
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
  end
end
