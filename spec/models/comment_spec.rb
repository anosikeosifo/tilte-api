require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryGirl.create :comment }

  it { should respond_to(:text) }
  it { should respond_to(:like_count) }
  it { should respond_to(:flagged) }
  it { should respond_to(:removed) }

  it { should belong_to(:user) }
  it { should belong_to(:post) }
end
