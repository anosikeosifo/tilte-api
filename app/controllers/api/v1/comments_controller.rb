class Api::V1::CommentsController < ApplicationController
  respond_to :json

  def index
    if params[:comment_ids]
      logger.error params[:comment_ids]
      comments = Comment.with_avatar.find(params[:comment_ids])
    else
      comments = Comment.with_avatar
    end

    render json: { success: true, data: ActiveModel::ArraySerializer.new(comments), message: "" }, status: 200
  end

  def flag
    comment = Comment.find_by(id: params[:id])

    if comment.update_attribute('flagged', true)
      render json: { success: true, data: CommentSerializer.new(comment), message: "" }, status: 200
    else
      render json: { success: false, data: "", message: comment.errors.full_messages.to_sentence }, status: 422
    end
  end

  def remove
    comment = Comment.find_by(id: params[:id])
    comment.remove!

    if comment.save
      render json: { success: true, data: CommentSerializer.new(comment), message: "" }, status: 200
    else
      render json: { success: false, data: "", message: comment.errors.full_messages.to_sentence }, status: 422
    end
  end

  def create
    comment = Comment.new(comment_params)

    if comment.save
      render json: { success: true, data: CommentSerializer.new(comment), message: "" }, status: 200, location:[:api, comment.post]
    else
      render json: { success: false, data: "", message: comment.errors.full_messages.to_sentence }, status: 422
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:text, :user_id, :post_id )
    end
end
