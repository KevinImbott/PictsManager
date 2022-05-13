class Album < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :pictures

  validates :name, presence: true

  def owner
    users.first
  end
end