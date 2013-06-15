# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#
class User < ActiveRecord::Base
  include ActiveModel::Validations
  attr_accessible :email, :name, :password, :password_confirmation
  #authenticate method  requires password_digest
  has_secure_password
  has_many :microposts, dependent: :destroy
  #callbacks
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  after_validation { self.errors.messages.delete(:password_digest) }
  validates :name, presence: true, length: {maximum: 50}
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #format: { with: VALID_EMAIL_REGEX }
  validates :email, presence: true,  email: true , uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true, length: {minimum: 6}
  def feed
    Micropost.where("user_id = ?", id)
  end
  private
    #Because of the way Active Record synthesizes attributes based on database columns,
    # without self the assignment would create a local variable called remember_token, which
    # isn’t what we want at all. Using self ensures that assignment sets the user’s
    # remember_token so that it will be written to the database along with the other attributes when the user is saved.
    #callback before save
    def create_remember_token
      # key on the session hash to get the user id
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
