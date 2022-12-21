# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string
#  password_digest :string
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

#FIGVAPEBR

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  # validations
  
  describe 'validates' do
    # before :each do
    #   create(:user)
    # end
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
  end

  describe 'uniqueness' do
    before :each do
      create(:user)
    end

    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:session_token) }
  end

  describe 'find user by credentials' do
    # find's a user that exists in our database
    let!(:user){create(:user)}
    

    it "finds a user" do 
      ex_user = user.find_by_credentials(user.username, user.password)
      expect(ex_user).to eq(user)
    end 

    # does not find a user that doesn't exist in our database
    it "returns a user from our database" do
      ex_user = user.find_by_credentials(user.username, user.password)
      expect(User.exists?(ex_user[:id])).to be true
    end 

  end

  describe 'is_password?' do
    let!(:user){create(:user)}

    it "returns true if password is correct" do 
      expect(user.is_password?(user.password)).to be true  
    end 

    it "returns false if password is incorrect" do 
      expect(user.is_password?("not password")).to be false
    end 
  end

  describe "reset session token" do
    let!(:user){create(:user)}
    
    it "returns a new session token" do
      token = user[:session_token]
      expect(user.reset_session_token).not_to eq(token)
    end 

    it "saves new sessiaon token to the database" do
      expect(user.reset_session_token).to be(user[:session_token])
    end 
  end 


end
