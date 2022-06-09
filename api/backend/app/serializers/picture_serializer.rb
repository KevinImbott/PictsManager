class PictureSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :updated_at, :url
  has_many :albums, serializer: AlbumPreviewSerializer
  has_many :invited_users, serializer: UserPreviewSerializer

  def url
    return unless object.img.key

    ActiveStorage::Blob.service.path_for(object&.img&.key)
  end

  def invited_users
    if object.albums.count.positive?
      @users = []
      object.albums.each do |album|
        @users |= album.invited_users
      end
      return @users
    end
    object.users.reject { |user| user == object.owner }
  end
end
