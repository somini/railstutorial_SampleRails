class User < ActiveRecord::Base
  SIMPLE_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  NORMAL_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  attr_accessor :remember_token

  validates :nick,
    presence: true,
    length: { maximum: 100 },
    uniqueness: true
  validates :mail,
    presence: true,
    length: { maximum: 256 },
    format: { with: NORMAL_EMAIL_REGEX }

  before_save {
    self.mail.downcase!
  }

  def remember_me
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.pass_digest(remember_token))
  end
  def forget_me
    update_attribute(:remember_token, nil)
  end

  # Spooky stuff
  has_secure_password
  validates :password,
    length: { minimum: 10 }

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    return BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  class << self
    # This seems a freaking hack
    def pass_digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
    # This is cool
    def new_token
      return SecureRandom.urlsafe_base64
    end
  end
end
