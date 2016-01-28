class PaymentsController < ApplicationController
	def create
		@product = Product.find(params[:product_id])
		@user = current_user
		token = params[:stripeToken]
		#Create the charge on Stripe's servers - this will charge the user's card
		begin
			charge = Stripe::Charge.create(
				:amount => (@product.price * 100).to_i(), # amount in cents
				:currency => "usd",
				:source => token,
				:description => params[:stripeEmail]
				)

			if charge.paid
				@order = Order.create(user: @user, product: @product, total: 1)
				PaymentMailer.order_completed(@order, @product.price).deliver_now
			end

		rescue Stripe::CardError => e
			# the card has been declined
			body = e.json_body
			err = body[:error]
			flash[:error] = "Unfortunately, there was an error processing your payment: #{err[:message]}"
		end
		#redirect_to product_path(@product)
	end
end
