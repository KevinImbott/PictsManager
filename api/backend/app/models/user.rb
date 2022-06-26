require 'bcrypt'

class User < ActiveRecord::Base
  has_secure_password

  self.per_page = 25

  has_and_belongs_to_many :albums
  has_and_belongs_to_many :pictures

  validates :email, presence: true
  validates :password, presence: true
  validates :pseudo, presence: true

  scope :by_recently_created, -> { order(created_at: :desc) }
  scope :by_earliest_created, -> { order(created_at: :asc) }

  def owned_albums
    Album.where(owner_id: id)
  end

  def owned_pictures
    Picture.where(owner_id: id)
  end
end
