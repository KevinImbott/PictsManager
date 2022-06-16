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
          link_to [album.id, album.name], admin_album_path(album.id)
        end
      end
    end
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :pseudo, :email, :password
  #
  # or
  #
  # permit_params do
  #   permitted = [:pseudo, :email, :password_digest]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
