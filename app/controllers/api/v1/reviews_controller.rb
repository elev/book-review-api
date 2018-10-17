class Api::V1::ReviewsController < ApplicationController
  before_action :load_book, only: [:index]
  before_action :load_review, only: [:show, :update, :destroy]
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]
  before_action :check_correct_user, only: [:update, :destroy]

  def index
    @reviews = @book.reviews
    json_response 'Index success', true, { reviews: @reviews }, :ok
  end
  
  def show
    json_response 'Success', true, {review: @review }, :ok
  end

  def create
    review = Review.new review_params
    review.user_id = current_user.id
    review.book_id = params[:book_id]

    if review.save
      json_response 'Created review successfuly', true, {review: review}, :ok
    else
      json_response 'Creating a review failed', false, {}, :unprocessable_entity
    end
  end

  def update
    if @review.update(review_params)
      json_response 'Updating review success', true, {review: @review}, :ok
    else
      json_response 'Updating review failed', false, {}, :unprocessable_entity
    end
  end

  def destroy
    if @review.destroy()
      json_response 'Deleting review success', true, {review: @review}, :ok
    else
      json_response 'Deleting review failed', false, {}, :unprocessable_entity
    end
  end

  private

  def load_book
    @book = Book.find_by(id: params[:book_id])
    unless @book.present?
      json_response 'Cannot find book', false, {}, :not_found
    end
  end

  def load_review
    @review = Review.find_by(id: params[:id])
    unless @review.present?
      json_response 'Cannot find review', false, {}, :not_found
    end
  end

  def review_params
    params.require(:review).permit :title, :content_rating, :recommend_rating
  end

  def check_correct_user
    unless correct_user(@review.user_id)
      json_response 'Incorrect Permissions', false, {}, :network_authentication_required
    end
  end
end