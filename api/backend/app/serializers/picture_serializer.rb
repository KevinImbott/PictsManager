class PictureSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :updated_at
  has_many :users
  has_many :albums
end
