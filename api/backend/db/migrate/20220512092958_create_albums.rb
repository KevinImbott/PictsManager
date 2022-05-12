class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.belongs_to :user
      t.belongs_to :picture
      t.timestamps
    end
  end
end
