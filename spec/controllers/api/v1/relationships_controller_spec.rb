require 'rails_helper'

RSpec.describe Api::V1::RelationshipsController, type: :controller do
  

  describe "GET #create" do
    before(:each) do
      @follower = FactoryGirl.create(:user)
      @followed = FactoryGirl.create(:user)
      # @follower.save
      # @followed.save
    end
    context "relationship is created successfully" do
      it "creates the user relationship" do
        post :create, { follower_id: follower.id, followed_id: followed.id }
      end

      expect(@follower.following.size).to eql(1)
    end

    context "relationship creation fails" do
      # before ()
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end

end
