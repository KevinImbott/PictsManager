# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: "Dashboard"

  content title: "Dashboard" do
    columns do
      column do
        panel "Last 10 Users" do
          ul do
            User.last(10).map do |user|
              li link_to "#{user.pseudo} : #{user.albums.count} Albums, #{user.pictures.count} Pictures", admin_user_path(user.id)
            end
          end
        end
      end

      column do
        panel "Last 10 Pictures" do
          ul do
            Picture.last(10).map do |picture|
              li link_to "#{picture.name}", admin_picture_path(picture.id)
            end
          end
        end
      end

      column do
        panel "Last 10 Albums" do
          ul do
            Album.last(10).map do |album|
              li link_to album.name, admin_album_path(album.id)
            end
          end
        end
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
  end # content
end
