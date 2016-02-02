class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @user = User.find_for_oauth(env["omniauth.auth"], current_user)

        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
        else
          session["devise.#{provider}_data"] = env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end
    }
  end

  def create
    email = params[:email]
    token = params[:token]
    provider = param[:provider]
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
        new_user.identity.build(provider: oauth_provider, token: user_token, uid: "testUID1234")
        return true
      else
        return false
      end
    rescue
      return false
    end
  end


  provides_callback_for :facebook

  def after_sign_in_path_for(resource)
    if resource.email_verified?
      super resource
    else
      finish_signup_path(resource)
    end
  end
end
