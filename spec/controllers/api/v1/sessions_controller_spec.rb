require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  before(:each) do
    #here i concatenate the json format into the request header, instead of passing it into each request
    set_header_properties
  end

  describe "GET #create" do #this is the signin test

    before(:each) do
      @user = FactoryGirl.create :user
    end

    context "Sign-in is successful" do
      before(:each) do 
        credentials = { email: @user.email, password: "test1234" }
        post :create, { session: credentials } #this creates a new credential
      end
      
      it "signs the user in" do
        @user.reload #this refreshes the user object so it adds on its newly updated attributes
        expect(json_response[:auth_token]).to eql(@user.auth_token)
      end

      it { should respond_with 200 }
    end
    
    context "Sign-in fails" do
      before(:each) do
        incomplete_credentials = { email: @user.email, password: "thisisaninvalidapassword" }

        post :create, { session: incomplete_credentials }
      end

      it "should not sign in the user" do
        expect(json_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do #sign out
    before(:each) do 
      @user = FactoryGirl.create :user
      signin user, store: false
      delete :destroy
    end

    it "should successfully sign the user out" do
      it { should respond_with 204 }
    end
  end
end
