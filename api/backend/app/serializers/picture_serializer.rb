class PictureSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :updated_at, :url
  has_many :users
  has_many :albums

  def url
    return unless object.img.key

    ActiveStorage::Blob.service.path_for(object&.img&.key)
  end
end