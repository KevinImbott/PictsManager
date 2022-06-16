ActiveAdmin.register Album do
  show do
    attributes_table do
      row :id
      row :name
      row :owner do |album|
        link_to album.owner.pseudo, admin_user_path(album.owner)
      end
      row :created_at
      row :updated_at
      table_for album.pictures do
        column 'Pictures' do |picture|
          img = image_tag url_for(picture.img)
          link_to img, admin_picture_path(picture.id)
        end
      end
      table_for album.invited_users do
        column 'Invited Users' do |user|
          link_to user.pseudo, admin_user_path(user.id)
        end
      end
    end
  end
end
