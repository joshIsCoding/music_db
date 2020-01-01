require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.create!(email:"test@spec.com", password:"test_password")}
  describe "Validations" do
    it { should validate_presence_of(:email) }    
    it { should validate_presence_of(:password_digest) }    
    it { should validate_presence_of(:session_token) }    
    it { should validate_length_of(:password).is_at_least(5) }
    it { should allow_value(nil).for(:password) }
  end

  describe "#is_password?" do
    it "verifies that a password is a users' password" do
      expect(user.is_password?("test_password")).to be true
      expect(user.is_password?("wrong_password")).to be false
    end
  end

  describe "#reset_session_token!" do
    it "Changes the users session_token" do
      old_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).not_to eq(old_token)
    end
  end

  describe "::find_by_credentials" do
    it "Returns a user matching the credentials" do
    expect(User.find_by_credentials(user.email, "test_password"))
    .to eq(user)
    end

    it "Returns nil if the credentials do not match any records" do
      expect(User.find_by_credentials(user.email, "woops"))
      .to be nil
      expect(User.find_by_credentials("no_user@spec.com", "test_password"))
      .to be nil
    end
  end
end
