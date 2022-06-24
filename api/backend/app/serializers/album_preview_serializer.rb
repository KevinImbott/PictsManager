class AlbumPreviewSerializer < ActiveModel::Serializer
  attributes :id, :name, :total_pictures

  def total_pictures
    object.pictures.count
  end
end
