class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :users
  has_many :pictures
end
