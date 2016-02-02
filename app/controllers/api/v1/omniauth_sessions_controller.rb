class Api::V1::OmniauthSessionsController < ApplicationController
  def create
    email = params[:email]
    uid = params[:uid]
    token = params[:token]
    provider = params[:provider] || "facebook"
    user = email.present? && User.joins(:identities).where(email: email, identities: { token: token }).first

    if user
      sign_in user, store: false
      user.generate_auth_token!
      user.save
      render json: { success: true, data: ActiveModel::ArraySerializer.new([user]), message: "" }, location: [:api, user], status: 200
    else
      if create_user_from_oauth(email, "password", token, provider, uid)
        render json: { success: true, data: ActiveModel::ArraySerializer.new([User.last]), message: "" }, status: 200
      else
        render json: { success: false, data: [], message: "Login failed. Please try again." }, status: 200
      end
    end
  end

  private

  def create_user_from_oauth(email, password, token, oauth_provider, uid)
    new_user = User.create!(email: email, password: password)
    if new_user.persisted?
      new_user.identities.create(provider: oauth_provider, token: token, uid: uid)
      return true
    else
      #add an error to the user object and return the object.
      return false
    end
  end
end
