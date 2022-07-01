class PictureSerializer < ActiveModel::Serializer
  attributes :id, :name, :tags, :created_at, :updated_at, :url, :albums
  has_many :invited_users, serializer: UserPreviewSerializer

  include Rails.application.routes.url_helpers

  def url
    return unless object.img.key

    rails_blob_path(object.img, only_path: true)
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
