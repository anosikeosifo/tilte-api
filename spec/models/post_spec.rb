require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should respond_to(:description) }
  it { should respond_to(:image_url) }


  it { should validate_presence_of(:description) }
  it { should be_valid }
end
