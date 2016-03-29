require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :first_name }
end

describe 'creating an club' do
  let!(:user) { create :user }
  it 'concats first and last name' do
    expect(user.full_name).to eq 'Little Kitty'
  end
end
