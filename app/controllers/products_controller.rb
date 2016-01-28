class ProductsController < ApplicationController
  before_filter :verify_is_admin!, only: [:edit, :update, :destroy, :create]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  respond_to :json, :html
  
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/search
  def index
    #byebug
    if params[:q]
      search_term = params[:q]
      @products = Product.where("description LIKE ?", "%#{search_term}%")
    else
      @products = Product.all
      respond_with @products
    end

    logger.debug "Product search results:"
    @products.each do |item|
      logger.debug "    Product: #{item.name} - #{item.description}"
    end
    logger.debug "And that's all folks!"
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @comments = @product.comments.paginate(page: params[:page], per_page: 5).order("created_at DESC")
    #byebug
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        flash[:alert] = @product.errors
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        flash[:alert] = @product.errors
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      product_id = params[:id]
      @product = (product_id.nil? ? nil : Product.find_by_id(product_id))
      if @product.nil?
        respond_to do |format|
          format.html { redirect_to products_url, alert: 'Product not found.' }
          format.json { render json: {}, status: :unprocessable_entity }
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :image_url, :color, :price)
    end

    def verify_is_admin!
      (current_user.nil?) ? redirect_to(new_user_session_path) : (redirect_to(products_url) unless current_user.admin?)
    end
end
