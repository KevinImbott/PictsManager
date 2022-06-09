class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name, :updated_at, :created_at
  has_many :pictures, serializer: PicturePreviewSerializer
  has_many :invited_users, serializer: UserPreviewSerializer

  def invited_users
    object.users.reject { |user| user == object.owner }
  end
end
