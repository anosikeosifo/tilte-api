class Api::V1::CommentsController < ApplicationController
  respond_to :json

  def index
    if params[:comment_ids]
      logger.error params[:comment_ids]
      comments = Comment.find(params[:comment_ids])
    else
      comments = Comment.all
    end

    respond_with comments
  end

  def flag
    comment = Comment.find_by(id: params[:id])
    
    if comment.update_attribute('flagged', true)
      render json: comment, status: 200
    else
      render json: { errors: "this post cannot be flagged at this time. Please try again." }
    end
  end

  def remove
    comment = Comment.find_by(id: params[:id])
    comment.remove!

    if comment.save
      render json: comment, status: 200
    else
      render json: { errors: "this post cannot be flagged at this time. Please try again." }
    end
  end

  def create
    comment = Comment.new(comment_params)

    if comment.save
      render json: comment, status: 200, location:[:api, comment.post] 
    else
      render json: {errors: comment.errors }
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:text, :removed, :flagged, :user_id, :post_id )
    end
end