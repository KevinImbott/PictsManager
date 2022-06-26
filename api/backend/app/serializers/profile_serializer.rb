class ProfileSerializer < ActiveModel::Serializer
  attributes :pseudo, :email, :created_at, :total_pictures, :total_albums

  def total_pictures
    object.owned_pictures.count
  end

  def total_albums
    object.owned_albums.count
  end
end
