class Api::V1::PostsController < ApplicationController

  respond_to :json
  def index
    if params[:post_ids]
      posts =  Post.find(params[:post_ids])
    else
      posts =  Post.all
    end
    respond_with posts
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
    user = User.find_by(id: params[:user_id])
    post = user.posts.find_by(id: params[:id])
    
    post.mark_as_removed!
    if post.save
      render json: post, status: 200, location: [:api, post]
    else
      render json: { errors: "Post could not be removed. Please try again" }, status: 422
    end
    
  end

  private 
    def post_params
      params.require(:post).permit(:description, :image_url, :user_id, :removed)
    end
end
