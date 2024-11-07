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

  # Generates a new token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Returns a hashed digest of the given token
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Generates and saves a remember token digest
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
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
