class CreatePicturesUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :pictures_users do |t|
      t.belongs_to :picture
      t.belongs_to :user
      t.timestamps
    end
  end
end
