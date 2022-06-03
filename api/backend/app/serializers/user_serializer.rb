class UserSerializer < ActiveModel::Serializer
  attributes :id, :pseudo, :email, :created_at
  has_many :pictures, class_name: "picture", foreign_key: "reference_id"
  has_many :albums, class_name: "album", foreign_key: "reference_id"
end
