class CreateAlbumsUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :albums_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :album
    end
  end
end
