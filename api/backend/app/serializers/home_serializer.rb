class HomeSerializer < ActiveModel::Serializer
  attributes :id, :url, :name, :owner_name

  include Rails.application.routes.url_helpers

  def url
    return unless object&.img&.key

    ActiveStorage::Blob.service.path_for(object&.img&.key)
  end

  def owner_name
    object.owner.pseudo
  end
end
