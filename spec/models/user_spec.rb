require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "Validations" do
    it { should validate_presence_of(:email) }    
    it { should validate_presence_of(:password_digest) }    
    it { should validate_presence_of(:session_token) }    
    it { should validate_length_of(:password).is_at_least(5) }
    it { should allow_value(nil).for(:password) }
  end

  
end
