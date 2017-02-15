class ReviewsController < ApplicationController
  load_and_authorize_resource

  def create
    @review = current_user.reviews.build review_params
    if @review.save
      status = t "documents.created_review_success"
    else
      status = t "documents.created_review_fails"
    end
    response_to_json status
  end

  def update
    if @review.update_attributes review_params
      status = t "documents.updated_review_success"
    else
      status = t "documents.updated_review_fails"
    end
    response_to_json status
  end

  private
  def review_params
    params.require(:review).permit :user_id, :document_id, :rating
  end

  def response_to_json status
    respond_to do |format|
      format.json {render json: {
        content: render_to_string({
          partial: "reviews/review", object: @review, formats: "html",
          layout: false}), review_id: @review.id,
          star_rewview_document: @review.document.rate_average.round(Settings.round),
          status: status
      }}
    end
  end
end
