ActiveAdmin.register Picture do
  show do
    attributes_table do
      row :id
      row :name
      row :description
      row :owner do |picture|
        link_to picture.owner.pseudo, admin_user_path(picture.owner)
      end
      row :image do |picture|
        if picture.img.attached?
          image_tag url_for(picture.img)
        end
      end
      row :created_at
      row :updated_at
      table_for picture.invited_users do
        column 'Invited Users' do |user|
          link_to user.pseudo, admin_user_path(user.id)
        end
      end
      table_for picture.albums do
        column 'Albums' do |album|
          link_to "Album #{album.id}: #{album.name}", admin_album_path(album.id)
        end
      end
    end
  end
end
