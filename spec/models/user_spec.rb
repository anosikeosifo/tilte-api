require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryGirl.create(:user) }
  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:auth_token) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:password) } 
  it { should validate_confirmation_of(:password) }

  it { should validate_uniqueness_of(:auth_token) }

  describe "#generate_auth_token!" do
    before(:each) { @user = FactoryGirl.create :user }
    it "generates auth_tokens dynamically" do
      Devise.stub(:friendly_token).and_return("uniquetoken123")
      @user.generate_auth_token!
      expect(@user.auth_token).to eql("uniquetoken123")
    end

    it "generates another token if the previously generated has alreeady been taken" do
      existing_user = FactoryGirl.create(:user, auth_token: "user_tokenX")
      @user.generate_auth_token!
      expect(@user.auth_token).not_to eql(existing_user.auth_token)  
    end
  end
end