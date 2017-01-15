class Api::V1::UsersController < ApplicationController
  respond_to                                :json
  before_action                             :authenticate_with_token!, only: [:update, :destroy]
  before_action                             :set_user, only: [:feed, :following, :followers, :favorites, :posts , :status]



  def index
    render json: { success: true, data: ActiveModel::Serializer::CollectionSerializer.new(User.all.includes(:posts, :favorites)), message: "" }, status: 200
  end

  def feed
    Post.signed_in_user = @user
    render json: { success: true, data: ActiveModel::Serializer::CollectionSerializer.new(@user.feed), message: "" }, status: 200
  end

  def show
    user = User.includes(:posts, :favorites).find_by(id: params[:id])
    render json: { success: true, data: UserSerializer.new(user), message: "" }, status: 200
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: { success: true, data: user, message: "" }, status: 201, location:[:api, user]
    else
      render json: { success: false, data: "", message: user.errors.full_messages.to_sentence }, status: 422
    end
  end

  def update
    #with the assumption that only a signed-in user can update himself
    user = current_user

    if user.update(user_params)
      render json: { success: true, data: user, message: "" }, status: 200, location:[:api, user]
    else
      render json: { success: false, data: "", message: user.errors.full_messages.to_sentence }, status: 422
    end
  end

  def followers
    followers = @user.get_followers
    render json: { success: true, count: followers.size, data: ActiveModel::Serializer::CollectionSerializer.new(followers), message: "" }, status: 200
  end

  def following
    following = @user.following
    render json: { success: true, count: following.size, data: ActiveModel::Serializer::CollectionSerializer.new(following), message: "" }, status: 200
  end

  def favorites
    favorites = @user.favorite_posts
    render json: { success: true, count: favorites, data: ActiveModel::Serializer::CollectionSerializer.new(favorites), message: "" }, status: 200
  end

  def posts
    user_posts = @user.posts
    render json: { success: true, count: user_posts.size,  data: ActiveModel::Serializer::CollectionSerializer.new(user_posts), message: "" }, status: 200
  end

  def status
    user_status = { followers: @user.followers.count, following: @user.following.count, posts: @user.posts.count, favorites: @user.favorites.count }
    render json: { success: true,  data: ActiveModel::Serializer::CollectionSerializer.new([user_status]), message: "" }, status: 200
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :avatar)
  end

  def set_user
    @user = User.includes(:favorites).find(params[:user_id])
  end

  def set_user
    user_id = JSON.parse(params["data"])["user_id"]
    @user = User.includes(:favorites).find(user_id)
  end
end
