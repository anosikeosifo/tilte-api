class Api::V1::SessionsController < ApplicationController
  respond_to :json
  def create
    user_email = params[:email]
    user_password = params[:password]
    user = user_email.present? && User.find_by(email: user_email)

    if user && user.valid_password?(user_password)
      sign_in user, store: false
      user.generate_auth_token!
      user.save
      render json: { success: true, data: ActiveModel::ArraySerializer.new([user]), message: "" }, location: [:api, user], status: 200
    else
      render json: { success: false, data: [], message: user.present? ? user.errors.full_messages.to_sentence : "No user exists with this email" }, status: 200
    end
  end

  def destroy
    user = User.find_by(auth_token: params[:id])
    user.generate_auth_token! #here i destroy the user's current session by generating a new token, so the token on the client and in d db are diff
    user.save
    head 204
  end
end
