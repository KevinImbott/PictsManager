require 'bcrypt'

class User < ActiveRecord::Base
  has_secure_password

  has_and_belongs_to_many :albums
  has_many :pictures, through: :albums

  validates :email, presence: true
  validates :password, presence: true
  validates :pseudo, presence: true
end
