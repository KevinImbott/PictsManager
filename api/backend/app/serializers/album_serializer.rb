class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name, :updated_at, :created_at, :invited_users
  has_many :pictures

  def invited_users
    object.users.reject { |user| user == object.owner }
  end
end
