class User < ApplicationRecord  
  has_attached_file :image, styles: { large: '200x200>',
                                      medium: '160x160>',
                                      thumb: '100x100>' }, default_url: '/assets/no-user.png'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  belongs_to :user_type, class_name: 'UserType', inverse_of: 'users'
  has_many :tickets, class_name: 'Ticket', inverse_of: 'user', dependent: :destroy
  delegate :name, to: :user_type, prefix: true

  attr_accessor :remember_token
  
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  validates :username, uniqueness: true, presence: true, length: { maximum: 50 }
  validates :profession, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :update, allow_blank: true

  # scope for agents count
  # User.agents_count
  scope :agents_count, -> {
    where(user_type_id: UserType.find_by(name: 'agent').id).count
  }

  # scope for customer count
  # User.customers_count
  scope :customers_count, -> {
    where(user_type_id: UserType.find_by(name: 'customer').id).count
  }

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
end
