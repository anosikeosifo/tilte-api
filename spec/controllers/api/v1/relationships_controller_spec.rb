require 'rails_helper'

RSpec.describe Api::V1::RelationshipsController, type: :controller do
  
  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }

  before(:each) do
    set_header_token(follower.auth_token)
    # sign_in follower 
  end

  describe "GET #create" do
    context "relationship is created successfully" do
      before do
        post :create, { followed_id: followed.id }
      end #at this point follower becomes the current user

      it "creates the user relationship" do
        expect(follower.following.size).to eql(1)
      end
    end

    context "relationship creation fails" do
      # before ()
    end
  end

  describe "GET #destroy" do
    before do
      follower.follow(followed)
      relationship = follower.relationships.find_by(followed: followed.id)
      delete :destroy, { id: relationship.id }
    end

    it "terminates the relationship between both users" do
      expect(follower.following).not_to include(followed)
    end
  end

end
