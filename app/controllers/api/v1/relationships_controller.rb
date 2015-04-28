class Api::V1::RelationshipsController < ApplicationController
  def create
    user_to_follow = User.find_by(id: params[:followed_id])
    current_user.follow(user_to_follow)

    render json: current_user, status: 200, location: [:api, current_user]
  end

  def destroy
    other_user = Relationship.find_by(id: params[:id]).followed #gets the associated followed user
    current_user.unfollow(other_user)
    head 204
  end
end
