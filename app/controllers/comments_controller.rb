class CommentsController < ApplicationController
	before_filter :authenticate_user!

	# POST /comments
	# POST /comments.json
	def create
		@product = Product.find(params[:product_id])
		@comment = @product.comments.new(comment_params)
		@comment.user = current_user
		respond_to do |format|
			if @comment.save
				format.html { redirect_to @product, notice: 'Review was created successfully.'}
				format.json { render :show, status: :created, location: @product }
				format.js
			else
				format.html { redirect_to @product, alert: 'Review was not saved successfully.' }
				format.json { render json: @comment.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /comments/1
	# DELETE /comments/1.json
	def destroy
		comment_id = params[:id]
		@comment = (comment_id.nil? ? nil : Comment.find_by_id(comment_id))
		respond_to do |format|
			if @comment.nil?
				format.html { redirect_to products_url, alert: 'Review not found.' }
				format.json { render json: { alert: 'Review not found.' }, status: :unprocessable_entity }
			else
				product = @comment.product
				if (current_user.admin? || @comment.user == current_user) && @comment.destroy
					format.html { redirect_to product, notice: 'Review was deleted.'}
					format.json { render :show, status: :created, location: product }
				else
					format.html { redirect_to product, alert: 'Review could not be deleted.' }
					format.json { render json: @comment.errors, status: :unprocessable_entity }
				end
			end
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:user_id, :body, :rating)
	end
end