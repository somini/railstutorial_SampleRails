class User < ActiveRecord::Base
  SIMPLE_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  NORMAL_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

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

  # Spooky stuff
  has_secure_password
  validates :password,
    length: { minimum: 10 }
  # This seems a freaking hack
  def User.pass_digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

end
