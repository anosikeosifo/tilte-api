class Api::V1::OmniauthSessionsController < ApplicationController
  def create
    email = params[:email]
    name = params[:name]
    uid = params[:uid]
    token = params[:token]
    avatar_url =  params[:profile_photo_url]
    provider = params[:provider] || "facebook"
    user = email.present? && User.joins(:identities).where(email: email, identities: { uid: uid }).first

    if user
      sign_in user, store: false
      user.generate_auth_token!
      user.save
      render json: { success: true, data: ActiveModel::ArraySerializer.new([user]), message: "existing_user" }, location: [:api, user], status: 200
    else
      if create_user_from_oauth(email, name, "password", token, provider, uid, avatar_url)
        render json: { success: true, data: ActiveModel::ArraySerializer.new([User.last]), message: "new_user" }, status: 200
      else
        render json: { success: false, data: [], message: "Login failed. Please try again." }, status: 200
      end
    end
  end

  private

  def create_user_from_oauth(email, name, password, token, oauth_provider, uid, avatar_url)
    new_user = User.create!(email: email, fullname: name, password: password, avatar: avatar_url)
    if new_user.persisted?
      new_user.identities.create(provider: oauth_provider, token: token, uid: uid)
      return true
    else
      #add an error to the user object and return the object.
      return false
    end
  end
end
