class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :load_reviewable

  def index
    @reviews = Review.all
  end

  def show
  end


  def new

    @review = @reviewable.reviews.new
  end

  def edit
  end

  def create
    @review = @reviewable.reviews.new(reviews_params)
    respond_to do |format|
      if @review.save
        format.html { redirect_to store_index_url, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # def update`
  #   respond_to do |format|
  #     if @review.update(reviews_params)
  #       format.html { redirect_to @review, notice: 'Review was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @review }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @review.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # def destroy
  #   @review.destroy
  #   respond_to do |format|
  #     format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def load_reviewable
      klass = [Food, Restaurant].detect { |c| params["#{c.name.underscore}_id"] }
      @reviewable = klass.find{params["#{klass.name.underscore}_id"]}
    end

    def reviews_params
      params.require(:review).permit(:name, :title, :description, :reviewable_type, :reviewable_id)
    end

end
