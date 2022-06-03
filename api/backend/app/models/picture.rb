class Picture < ActiveRecord::Base
  has_and_belongs_to_many :albums
  has_and_belongs_to_many :users

  has_one_attached :img

  validates :name, presence: true
  validates :description, presence: true

  after_destroy :destroy_blob

  def owner
    users.first
  end

  private

  def destroy_blob
    self&.img&.purge
  end
end
