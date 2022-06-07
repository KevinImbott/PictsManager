class PicturePreviewSerializer < ActiveModel::Serializer
  attributes :id, :url

  include Rails.application.routes.url_helpers

  def url
    return unless object.img.key

    variant = object.img.variant(resize: "100x100")
    rails_representation_url(variant, only_path: true)
    # ActiveStorage::Blob.service.path_for(object&.img&.key)
  end
end
