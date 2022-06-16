ActiveAdmin.register User do


  show do
    attributes_table do
      row :id
      row :pseudo
      row :email
      row :created_at
      row :updated_at
      table_for user.pictures do
        column 'Pictures' do |picture|
          link_to picture.name, admin_picture_path(picture.id)
        end
      end
      table_for user.albums do
        column 'Albums' do |album|
          link_to "Album #{album.id}: #{album.name}", admin_album_path(album.id)
        end
      end
    end
  end
end
