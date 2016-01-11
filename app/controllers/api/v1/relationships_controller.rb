class Api::V1::RelationshipsController < ApplicationController
  respond_to :json

  def create
    user_to_follow = User.find_by(id: params[:followed_id])
    follower = User.find_by(id: params[:follower_id])
    follower.follow!(user_to_follow)

    render json: { success: true, data: follower, message: "" }, status: 200, location: [:api, follower]
  end

  def destroy
    begin
      other_user = User.find_by(id: params[:followed_id]) #Relationship.find_by(id: params[:id]).followed #gets the associated followed user
      user = User.find_by(id: params[:follower_id])
      user.unfollow!(other_user)
      render json: { success: true, data: "", message: "Relationship destroyed" }, status: 204
    rescue StandardError => e
      render json: { success: false, data: "", message: e.message }, status: 400
    end
  end
end
