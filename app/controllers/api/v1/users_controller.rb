class Api::V1::UsersController < ApplicationController
  respond_to :json

  before_action :authenticate_with_token!, only: [:update, :destroy]
  def index
    render json: { success: true, data: ActiveModel::ArraySerializer.new(User.all.includes(:posts, :favorites)), message: "" }, status: 200
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
    user = User.find_by(id: params[:id])
    render json: { success: true, data: ActiveModel::ArraySerializer.new(user.followers), message: "" }, status: 200
  end

  def following
    user = User.find_by(id: params[:id])
    render json: { success: true, data: ActiveModel::ArraySerializer.new(user.following), message: "" }, status: 200
  end


  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :avatar)
  end
end
