class Api::V1::CommentsController < ApplicationController
  respond_to :json
  before_action :set_post, except: [:index]

  def index
    if params[:comment_ids]
      logger.error params[:comment_ids]
      comments = Comment.find(params[:comment_ids])
    else
      comments = Comment
    end

    render json: { success: true, data: ActiveModel::Serializer::CollectionSerializer.new(comments), message: "" }, status: 200
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
    params_data = JSON.parse(params[:data])
    comment = @post.comments.build(text: params_data["text"], user: User.find(params_data["user_id"]))
    if comment.save
      render json: { success: true, data: ActiveModel::Serializer::CollectionSerializer.new([comment]), message: "" }, status: 200
    else
      render json:  { success: false, data: "", message: comment.errors.full_messages.to_sentence }, status: 422
    end
  end

  private
  def set_post
    post_id = JSON.parse(params["data"])["moment_id"]
    @post = Post.find(post_id)
  end
end
