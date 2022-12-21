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
    # find's user

    context 'leverages our password to confirm user' do
      
    end

  end
end
