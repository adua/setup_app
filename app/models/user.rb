# == Schema Information
# Schema version: 20110608143704
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence => true
  validates :name, :length   => { :maximum => 50 }

  validates :email, :presence => true
  validates :email, :format => { :with => email_regex }
  validates :email, :uniqueness => { :case_sensitive => false }

  validates :password, :presence => true
  validates :password, :confirmation => true
  validates :password, :length => { :within => 5..20 }

  before_save :encrypt_password

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  private

  def encrypt_password
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
    string
  end

  def self.authenticate(submitted_email, submitted_password)
    user = find_by_email(submitted_email)
    return nil if user.nil?
    return user if user_has_password?(submitted_password)
  end

end
