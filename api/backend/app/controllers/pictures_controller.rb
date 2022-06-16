# frozen_string_literal: true

class PicturesController < AuthenticatedController
  def index
    pictures = policy_scope(current_user.pictures)
    render json: pictures, each_serializer: PicturePreviewSerializer
  end

  def show
    authorize picture
    render json: picture
  end

  def create
    new_picture = Picture.new(permitted_params)
    new_picture.owner = current_user
    new_picture.img.attach(params['img'])
    if new_picture.save
      new_picture.users = [current_user]
      render json: new_picture, status: :created
    else
      render json: { errors: new_picture.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize picture
    return if picture&.update(permitted_params)

    render json: { errors: picture&.errors&.full_messages }, status: :unprocessable_entity
  end

  def add_or_delete_user
    authorize picture
    if user_exist_in_picture?
      picture.users.delete(user)
      picture.save
      render json: { message: 'User Deleted' }
    else
      picture.users.push(user)
      picture.save
      render json: { message: 'User Added' }
    end
  end

  def add_or_delete_album
    authorize picture
    if picture_exist_in_album?
      picture.albums.delete(album)
      picture.save
      render json: { message: 'Picture Deleted' }
    else
      picture.albums.push(album)
      picture.save
      render json: { message: 'Picture Added' }
    end
  end

  def destroy
    authorize picture
    return if picture&.destroy

    render json: { errors: picture&.errors&.full_messages }, status: :unprocessable_entity
  end

  private

  def permitted_params
    params.permit([:name, :description, :url])
  end

  def user_exist_in_picture?
    picture.users.find_by(id: user.id)
  end

  def picture_exist_in_album?
    picture.albums.find_by(id: album.id)
  end

  def picture
    picture ||= Picture.find_by(id: params[:id])
  end

  def album
    album ||= Album.find_by(id: params[:album_id])
  end

  def user
    user ||= User.find_by(id: params[:user_id])
  end
end
