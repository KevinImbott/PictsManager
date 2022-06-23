require 'bcrypt'

class User < ActiveRecord::Base
  has_secure_password

  self.per_page = 25

  has_and_belongs_to_many :albums
  has_and_belongs_to_many :pictures

  validates :email, presence: true
  validates :password, presence: true
  validates :pseudo, presence: true

  scope :by_recently_created, -> { order(created_at: :desc).limit(20) }
  scope :by_earliest_created, -> { order(created_at: :asc).limit(20) }
end
