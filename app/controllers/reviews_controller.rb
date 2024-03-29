class ReviewsController < ApplicationController
  # GET /reviews
  # GET /reviews.json

  # before_filter :setup_review, :only => [:new]

  # def setup_review
  #   @reviews = Review.all
  # end
  
  # def index
  #   # @reviews = Review.all
  #   # @product_id = @reviews.map {|r| r.product_id}
  #   # @product_name = Product.find(@review.product_id).name

  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render json: @reviews }
  #   end
  # end

  # # GET /reviews/1
  # # GET /reviews/1.json
  # def show
  #   @review = Review.find(params[:id])
  #   @product_name = Product.find(@review.product_id).name

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @review }
  #   end
  # end

  # GET /reviews/new
  # GET /reviews/new.json
  def new
    @review = Review.new
    @products = Product.all

  #Create @product_name ONLY IF product_id is passed in 
    if params[:product_id]
    @product_name = @products.find{|p| p.id == params[:product_id].to_i}.name
    # @product_name = @products.select{|p| p.id == params[:product_id].to_i}[0].name
    end 

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @review }
    end
  end

  # # GET /reviews/1/edit
  # def edit
  #   @review = Review.find(params[:id])
  # end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(params[:review])

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: 'Review was successfully created.' }
        format.json { render json: @review, status: :created, location: @review }
      else
        format.html { render action: "new" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # # PUT /reviews/1
  # # PUT /reviews/1.json
  # def update
  #   @review = Review.find(params[:id])

  #   respond_to do |format|
  #     if @review.update_attributes(params[:review])
  #       format.html { redirect_to @review, notice: 'Review was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @review.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /reviews/1
  # # DELETE /reviews/1.json
  # def destroy
  #   @review = Review.find(params[:id])
  #   @review.destroy

  #   respond_to do |format|
  #     format.html { redirect_to reviews_url }
  #     format.json { head :no_content }
  #   end
  # end
end
