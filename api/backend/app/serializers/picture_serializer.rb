class PictureSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :updated_at, :url, :albums
  has_many :invited_users, serializer: UserPreviewSerializer

  def url
    return unless object.img.key

    ActiveStorage::Blob.service.path_for(object&.img&.key)
  end

  def albums
    albums = []
    object.owner.owned_albums.each do |album|
      albums << { name: album.name, on_album: object.albums.include?(album), id: album.id }
    end
    albums
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
