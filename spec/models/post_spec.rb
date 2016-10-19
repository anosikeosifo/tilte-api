require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryGirl.create(:post) }
  subject{ post }

  it { should respond_to(:description) }
  it { should respond_to(:image_url) }
  it { should respond_to(:removed) }

  it { should validate_presence_of(:description) }
  it { should be_valid }

  it { should belong_to(:user) }
end
