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

require 'bcrypt'

class User < ApplicationRecord
    after_initialize :ensure_session_token
    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: { minimum: 6 }, allow_nil: true

    attr_reader :password

    def find_by_credentials(username, password)
        @user = User.find_by(username: username)

        if @user && is_password?(password)
            @user
        else
            nil
        end 
    end 

    def is_password?(password)
        password_object = BCrypt::Password.new(self.password_digest)
        password_object.is_password?(password)
    end 

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    #R

    def generate_session_token
        SecureRandom::urlsafe_base64
    end

    def ensure_session_token
        self.session_token ||= generate_session_token
        # SecureRandom::urlsafe_base64
    end

end
