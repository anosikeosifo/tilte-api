require 'rails_helper'

RSpec.describe Api::V1::PostsController do
  before(:each) do
    #here i concatenate the json format into the request header, instead of passing it into each request
    set_header_properties
  end
  describe "GET #show" do
    before(:each) do
      # @user = FactoryGirl.create :user
      @post = FactoryGirl.create(:post)
      get :show, id: @post.id
    end

    it "should return the post with specified id" do
      post_response = json_response[:post]
      expect(post_response[:id]).to eql(@post.id)
    end

    it "has the user as an embedded object" do
      post_response = json_response[:post]
      expect(post_response[:user][:email]).to eql(@post.user.email)
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before do
      3.times { FactoryGirl.create :post }
      get :index
    end

    it "should return a list of the created posts" do
      posts_response = json_response[:posts]
      expect(posts_response.size).to eql 3
    end

    it { should respond_with 200 }
  end

  describe "PUT/PATCH #update" do
    before do
      @user = FactoryGirl.create(:user)
      @post = FactoryGirl.create(:post, user: @user)
    end

    context "when post is updated successfully" do  
      before do
        patch :update, { id: @post.id, user_id: @user.id, post: { description: "this is an updated description of the post" } }
      end

      it "should update the post description" do
        post_response = json_response[:post]
        expect(post_response[:description]).to eql("this is an updated description of the post")
      end
    end

    context "when post update fails" do

    end
  end

  describe "GET #create" do
    context "when post is successfully created" do
      before do 
        @user = FactoryGirl.create :user
        @post_attribute = FactoryGirl.attributes_for(:post)
      end

      it "should create the user" do
        expect { 
          post :create, { post: @post_attribute, user_id: @user.id } 
        }.to change(Post, :count).by(1)
      end
    end

    context "when post creation fails" do
      before do 
        user = FactoryGirl.create :user
        #create a post with an invalid description
        post_attribute = FactoryGirl.attributes_for(:post, description: "")
        post :create, { post: post_attribute, user_id: user.id } 
      end

      it "returns an error" do
        post_response = json_response
        expect(post_response).to have_key(:errors)
      end
    end
  end

  describe "POST #remove" do
    before do
      @user = FactoryGirl.create(:user)
      @post = FactoryGirl.create(:post, user: @user)
    end

    context "when post is removed successfully" do
       before do
        post :remove, { id: @post.id, user_id: @user.id }
      end

      it "should mark the post as removed" do
        # @post.reload
        post_response = json_response[:post]
        expect(post_response).to have_key(:removed) # eql(true)
      end

      it { should respond_with 200 }
    end

    context "when post removal fails" do
      
    end
  end

end
