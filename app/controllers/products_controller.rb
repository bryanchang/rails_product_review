class ProductsController < ApplicationController
  # GET /products
  # GET /products.json
  before_filter :products_in_cart

  def products_in_cart
    @products_in_cart = Product.where(:in_cart => true)
    @prices_in_cart = @product_in_cart.map{|p| p.price}
    @total_price = @prices_in_cart.inject(:+)
  end


  def index
    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
    @reviews = Review.where(:product_id => @product.id)
    # ------------ My first approach on Review Body -------
    #   reviews = Review.all
    #   product_reviews = reviews.select{|r| r.product_id == @product.id}
    # @product_reviews_body = product_reviews.map{|r| r.body}

    file = open("https://www.googleapis.com/shopping/search/v1/public/products?key=AIzaSyAypfaGqJYG0kPrsTGhzfZN2VXg0JcRS-0&country=US&q=#{URI.escape(@product.name)}&alt=json", :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE)
    @result = JSON.load(file.read)['items'][0]['product']


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end
end
