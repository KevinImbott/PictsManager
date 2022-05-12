class CreateAlbumsPictures < ActiveRecord::Migration[7.0]
  def change
    create_table :albums_pictures do |t|
      t.belongs_to :picture
      t.belongs_to :album
    end
  end
end
