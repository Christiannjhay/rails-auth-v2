class User < ApplicationRecord
  has_secure_password
  
  enum role: { user: 0, admin: 1 }

  validates :first_name, :last_name, :mobile, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validate :passwords_match

  attr_accessor :password_1, :password_2 

  after_initialize :set_default_role, if: :new_record?

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
