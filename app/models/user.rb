class User < ApplicationRecord
    before_create :create_remember_digest

    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: { minimum: 6 }
    has_secure_password

    def User.new_token 
        SecureRandom.urlsafe_base64
    end

    def User.digest(token)
        Digest::SHA1.hexdigest(token.to_s)
    end

    def remember(token)
        update_attribute(:remember_digest, User.digest(token))
    end

    def forget
        update_attribute(:remember_digest, nil)
    end

    private

        #before_filter

        def create_remember_digest
            self.remember_digest = User.digest(User.new_token)
        end

end
