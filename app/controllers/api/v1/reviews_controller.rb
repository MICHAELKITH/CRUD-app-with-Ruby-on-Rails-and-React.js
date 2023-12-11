module Api
    module V1
      class ReviewsController < ApplicationController
        protect_from_forgery with: :null_session
  
        def create
          review = Review.new(review_params)
  
          if review.save
            render json: ReviewSerializer.new(review).serialized_json
          else
            render json: { errors: review.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        def destroy
          review = current_user.reviews.find(params[:id])
  
          if review.destroy
            head :no_content
          else
            render json: { errors: review.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        private
  
        # Strong params
        def review_params
          params.require(:review).permit(:title, :description, :score, :airline_id)
        end
      end
    end
  end
  