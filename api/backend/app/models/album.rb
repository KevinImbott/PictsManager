class Album < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :pictures

  validates :name, presence: true

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
end
