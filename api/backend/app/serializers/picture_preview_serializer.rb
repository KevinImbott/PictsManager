class PicturePreviewSerializer < ActiveModel::Serializer
  attributes :id, :url

  include Rails.application.routes.url_helpers

  def url
    return unless object.img.key

    ActiveStorage::Blob.service.path_for(object&.img&.key)
  end
end
