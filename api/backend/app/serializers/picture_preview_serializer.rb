class PicturePreviewSerializer < ActiveModel::Serializer
  attributes :id, :url

  include Rails.application.routes.url_helpers

  def url
    return unless object.img.key

    rails_blob_path(object.img, only_path: true)
  end
end
