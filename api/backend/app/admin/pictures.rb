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
      table_for picture.users do
        column 'Invited Users' do |user|
          if user != picture.owner
            link_to user.pseudo, admin_user_path(user.id)
          end
        end
      end
      table_for picture.albums do
        column 'Albums' do |album|
          link_to "Album #{album.id}: #{album.name}", admin_album_path(album.id)
        end
      end
    end
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :description, :owner_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :owner_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
