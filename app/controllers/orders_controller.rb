class OrdersController < ApplicationController
	protect_from_forgery
	skip_before_action :verify_authenticity_token, if: :json_request?
	respond_to :json, :html
	before_filter :authenticate_user!

	def index
		@orders = Order.all.to_json(:include => [{:product => {:only => :name}}, {:user => {:only => :email}}])
		respond_with @orders
	end

	def show
		@order = Order.find(params[:id]).to_json(:include => [{:product => {:only => :name}}, {:user => {:only => :email}}])
		respond_with @order
	end

	def create
		@order = Order.new(order_params)
		@order.user = current_user
		if @order.save
			respond_with @order
		else
			render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def destroy
		respond_with Order.destroy(params[:id])
	end

	protected

	def json_request?
		request.format.json?
	end

	private

	def order_params
		order = params.require(:order).permit(:product_id, :total)
	end
end
