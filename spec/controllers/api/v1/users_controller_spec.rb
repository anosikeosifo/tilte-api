require 'rails_helper'

RSpec.describe Api::V1::UsersController do

  before(:each) do
    #here i concatenate the json format into the request header, instead of passing it into each request
    set_header_properties
  end
  # describe "GET #index" do
  #   before(:each) do
  #     3.times { FactoryGirl.create(:user) }
  #     get :index
  #   end


  #   it "returns the profiles of all the users subscribed to the app" do
  #     user_response = json_response
  #     expect(user_response.size).to eql(3)
  #   end

  #   it { should respond_with 200 }
  # end

  describe "GET #show" do
    before(:each) do 
      @user = FactoryGirl.create(:user)
      get :show, id: @user.id
    end

    it "shows the detail of the user specified by the id" do
      user_response = json_response[:user]
      expect(user_response[:email]).to eql(@user.email)
    end

    it "has the ids of user posts as an embedded object" do
      user_response = json_response[:user]
      expect(user_response[:post_ids]).to eql []
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    
    context "When user creation is successful" do
      before(:each) do
        @user_attributes = FactoryGirl.attributes_for :user #this creates attributes for a user object..for further use
        post :create, { user: @user_attributes }
      end

      it "creates the user and returns a json representation of same" do
        user_response = json_response[:user]
        expect(user_response[:email]).to eql(@user_attributes[:email]) 
      end
    end

    context "when user creation fails" do
      before(:each) do
        @user_attributes = { email: "test_user@email.com" } #incomplete user attrs, no password and confirmation 
        post :create, { user: @user_attributes }
      end

      it "should return an error indicating a failed user-creation" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "returns a text indicating why user-creation failed" do
        user_response = json_response
        expect(user_response[:errors][:password]).to include "can't be blank"
      end
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user

      set_header_token(@user.auth_token)
      # request.headers["Authorization"] = @user.auth_token
    end

    context "when successful" do
      before(:each) do
        patch :update, { id: @user.id, user: { email: "updated_user@email.com"} }
      end

      it "should update successfully" do
        @user.reload
        user_response = json_response[:user]
        expect(user_response[:email]).to eql(@user.email)
      end

      it { respond_with 200 }
    end


    context "when unsuccessful" do

    end
  end

  describe "#followers" do

  end

  describe "#following" do

  end

end