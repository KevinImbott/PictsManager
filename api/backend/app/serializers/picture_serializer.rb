class PictureSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :updated_at, :invited_users
  # has_many :users
  has_many :albums

  private

  def invited_users
    users.reject { |user| user == owner }
  end
end
