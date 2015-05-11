class Api::V1::PostsController < ApplicationController

  respond_to :json
  def index
    respond_with Post.all
  end

  def update
    user = User.find_by(id: params[:user_id])
    post = user.posts.find_by(id: params[:id])

    if post.update(post_params)
      render json: post, status: 200, location: [:api, post]
    else
      render json: { errors: post.errors }, status: 422
    end
  end

  def create
    post = Post.new(post_params)

    if post.save
      render json: post, status: 200, location:[:api, post]
    else
      render json: { errors: post.errors }, status: 422
    end
  end

  def show 
    respond_with Post.find_by(id: params[:id])
  end

  def remove
  end

  private 
    def post_params
      params.require(:post).permit(:description, :image_url, :user_id)
    end
end
