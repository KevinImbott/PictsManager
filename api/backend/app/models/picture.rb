class Picture < ActiveRecord::Base
  has_and_belongs_to_many :albums
  has_many :users, through: :albums

  def owner
    users.first
  end
end
