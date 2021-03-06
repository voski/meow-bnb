# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_reader :password
  validates :user_name, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  after_initialize :ensure_session_token

  has_many :cats
  has_many(
    :requests,
    class_name: 'CatRentalRequest',
    foreign_key: :user_id,
    primary_key: :id
  )

  def self.find_by_credentials(credentials)

    user = User.find_by(user_name: credentials['user_name'])

    return nil if user.nil?
    user.password_digest.is_password?(credentials['password']) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def password_digest
    BCrypt::Password.new(super)
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    session_token
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
