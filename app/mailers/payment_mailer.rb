class PaymentMailer < ApplicationMailer
	default from: "corie.wiren@gmail.com"

	def order_completed(order, price)
		@appname = "NiCho Chocolate"
		@order = order
		@price = price
		mail(:to => order.user.email,
			 :subject => "#{@appname}: Thank you for your order!")
	end
end