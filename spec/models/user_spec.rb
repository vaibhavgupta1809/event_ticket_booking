require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    puts FactoryBot.factories.map(&:name)
    expect(create(:user)).to be_valid
  end
end