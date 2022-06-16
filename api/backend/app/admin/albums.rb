ActiveAdmin.register Album do
  show do
    attributes_table do
      row :id
      row :name
      row :owner do |picture|
        link_to picture.owner.pseudo, admin_user_path(picture.owner)
      end
      row :created_at
      row :updated_at
      table_for album.pictures do
        column 'Pictures' do |picture|
          link_to picture.name, admin_picture_path(picture.id)
        end
      end
      table_for album.invited_users do
        column 'Users' do |user|
          link_to user.pseudo, admin_user_path(user.id)
        end
      end
    end
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :owner_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :owner_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
