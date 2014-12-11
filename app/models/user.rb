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
end
