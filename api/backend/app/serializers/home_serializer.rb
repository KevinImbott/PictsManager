class HomeSerializer < ActiveModel::Serializer
  attributes :id, :url, :name, :owner_name, :tags

  include Rails.application.routes.url_helpers

  def url
    return unless object&.img&.key

    rails_blob_path(object.img, only_path: true)
  end

  def owner_name
    object.owner.pseudo
  end
end
