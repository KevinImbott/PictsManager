class Picture < ActiveRecord::Base
  has_and_belongs_to_many :albums
  has_and_belongs_to_many :users

  has_one_attached :img

  validates :name, presence: true
  validates :description, presence: true

  after_destroy :destroy_blob

  self.per_page = 10

  def owner
    User.find_by(id: owner_id)
  end

  def owner=(user)
    self.owner_id = user.id
  end

  def invited_users
    users.reject { |user| user == owner }
  end

  private

  def destroy_blob
    self&.img&.purge
  end
end
