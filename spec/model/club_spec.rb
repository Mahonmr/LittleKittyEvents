require 'rails_helper'

RSpec.describe Club, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :location }
end
