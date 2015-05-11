class Api::V1::UsersController < ApplicationController
  respond_to :json
  
  before_action :authenticate_with_token!, only: [:update, :destroy]
  def index
    respond_with User.all
  end

  def show
    respond_with User.find_by(id: params[:id])
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: 201, location:[:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    #with the assumption that only a signed-in user can update himself
    user = current_user

    if user.update(user_params)
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def followers 
    user = User.find_by(id: params[:id])
    render json: user.followers, status: 200
  end

  def following
    user = User.find_by(id: params[:id])
    render json: user.following, status: 200
  end


  private 
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :avatar)
  end
end
