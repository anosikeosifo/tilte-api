require 'rails_helper'

RSpec.describe Relationship, type: :model do

  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }
  let(:relationship) { follower.relationships.build(followed_id: followed.id) }
    
  subject { relationship }


  it { should respond_to(:follower_id) }
  it { should respond_to(:followed_id) }

  it "should return matching relationship properties" do
    expect(relationship.follower).to eql follower
    expect(relationship.followed).to eql followed
  end


  it { should validate_presence_of(:follower_id) } 
  it { should validate_presence_of(:followed_id) } 
  
  # it { should be_valid }
end
