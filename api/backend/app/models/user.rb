require 'bcrypt'

class User < ActiveRecord::Base
  has_secure_password

  has_and_belongs_to_many :albums
  has_many :pictures, through: :albums

  validates :email, presence: true
  validates :password, presence: true
  validates :pseudo, presence: true

  scope :by_recently_created, -> { order(created_at: :desc).limit(20) }
  scope :by_earliest_created, -> { order(created_at: :asc).limit(20) }
end
