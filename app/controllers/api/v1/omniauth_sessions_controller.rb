class Api::V1::OmniauthSessionsController < ApplicationController
  def create
    email = params[:email]
    token = params[:token]
    provider = params[:provider] || "facebook"
    user = email.present? && User.joins(:identity).where(email: email, token: token).first

    if user
      sign_in user, store: false
      user.generate_auth_token!
      user.save
      render json: { success: true, data: ActiveModel::ArraySerializer.new([user]), message: "" }, location: [:api, user], status: 200
    else
      if create_user_from_oauth(email, password, token, provider)
        render json: { success: false, data: [], message: user.present? ? user.errors.full_messages.to_sentence : "No user exists with this email" }, status: 200
      end
    end
  end

  private

  def create_user_from_oauth(email, password, token, oauth_provider)
    begin
      new_user = User.create!(email: email, password: password)
      if new_user.persisted?
        Identity.create!(provider: oauth_provider, token: user_token, uid: "testUID1234", user_id: new_user.id)
        return true
      else
        return false
      end
    rescue
      return false
    end
  end
end
