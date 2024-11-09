class User < ApplicationRecord
  has_secure_password
  
  attr_accessor :remember_token
  # Enum for user roles
  enum role: { user: 0, admin: 1 }

  # Validations
  validates :first_name, :last_name, :mobile, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validate :passwords_match

  # Virtual attributes for password confirmation
  attr_accessor :password_1, :password_2 

  # Callbacks
  after_initialize :set_default_role, if: :new_record?

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
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

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
  BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
  update_attribute(:remember_digest, nil)
  end
  


  private
  
  def set_default_role
    self.role ||= :user
  end

  def passwords_match
    if password_1 != password_2
      errors.add(:base, "Password confirmation does not match Password")
    end
  end

end
