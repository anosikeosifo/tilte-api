require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "GET #index" do
    it "returns the profiles of all the users subscribed to the app" do
      before(:each) do
        @user  = FactoryGirl.create(:user)
      end
    end
  end
end
