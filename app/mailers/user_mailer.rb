class UserMailer < ApplicationMailer
	default from: "corie.wiren@gmail.com"

	def contact_form(email, name, message)
		@message = message
		mail(:from => email,
			:to => "corie.wiren@gmail.com",
			:subject => "A new contact form message from #{name}")
	end

	def welcome(user)
		@appname = "NiCho Chocolate"
		mail( :to => user.email,
			:subject => "Welcome to #{@appname}!")
	end
end