class User < ApplicationRecord
    attr_accessor :remember_token

    # one to many relationship with notes
    has_many :notes
    has_secure_password

    # Make sure it is in lowercase before saving to database
    before_save { self.email = email.downcase }
    before_create :create_remember_token

    # Validations to fill all fields
    validates :name, presence: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: { minimum: 6 }

    # Returns the hash digest of the string
    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  
    # Returns a random token.
    def User.new_token
      SecureRandom.urlsafe_base64
    end

    # Remembers a user in the database for use in persistent sessions.
    def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
    end

    # Returns true if the token matches the digest
    def authenticated?(remember_token)
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    # Forgets a user.
    def forget
      update_attribute(:remember_digest, nil)
    end

    #Generates a random URL-safe base64 string
    def User.new_remember_token
      SecureRandom.urlsafe_base64
    end
  
    #Encrypt user token
    def User.encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
    end
  
    private
  
    # assign to one of the user attributes
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
  