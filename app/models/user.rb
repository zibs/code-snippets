class User < ActiveRecord::Base

  has_many :snippets, dependent: :destroy

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  # temporarily store password in memory
  # attr_accessor :password
  # attr_accessor :password_confirmation
  # add ^^ attributes for us.
  has_secure_password
  validates :password, length: { minimum: 5 }, on: :create
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
            uniqueness: true,
            format: VALID_EMAIL_REGEX

  def full_name
    "#{first_name} #{last_name}".titleize.strip
  end

end
