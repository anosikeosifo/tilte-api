require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do
  before(:each) do
    set_header_properties
  end

  describe "GET #index" do
    before do
      @user = FactoryGirl.create(:user)
      @post = FactoryGirl.create(:post, user_id: @user.id)

      3.times { FactoryGirl.create(:comment, user: @user, post: @post) }
      get :index, { post_id: @post.id }
    end

    it "returns all the existing comments" do
      comments_response = json_response[:comments]
      expect(comments_response.size).to eql 3
    end
  end

  describe "GET #flag" do
    before do
      @comment = FactoryGirl.create(:comment)
      post :flag, id: @comment
    end

    it "should flag the comment as inappropriate" do
      comment_response = json_response[:comment]
      expect(comment_response[:flagged]).to eql true
    end
  end

  describe "GET #remove" do
    before do
      @comment = FactoryGirl.create(:comment)
      post :remove, id: @comment
    end

    it "should remove the comment" do
      comment_response = json_response[:comment]
      expect(comment_response[:removed]).to eql true
    end
  end

  describe "POST #create" do

    before do
      @user = FactoryGirl.create(:user)
      @post = FactoryGirl.create(:post, user_id: @user.id)
      @comment_attributes = FactoryGirl.attributes_for(:comment, user_id: @user.id, post_id: @post.id)
    end

    it "creates the comment and increases the count" do
      expect { post :create, 
        { comment: @comment_attributes, user_id: @user.id, post_id: @post.id }
        }.to change(Comment, :count).by(1)
    end
  end
end

