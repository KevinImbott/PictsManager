# frozen_string_literal: true

class PicturesController < ApplicationController
  def index
    pictures = @current_user.pictures
    render json: pictures, each_serializer: PicturePreviewSerializer
  end

  def show
    if picture&.owner == @current_user
      render json: picture
    else
      render json: { message: 'Unauthorized' }, status: :unauthorized
    end
  end

  def create
    new_picture = Picture.new(permitted_params)
    new_picture.owner = @current_user
    if new_picture.save
      new_picture.users = [@current_user]
      new_picture.img.attach(params['picture'])
      render json: new_picture, status: :created
    else
      render json: { errors: new_picture.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if picture&.owner == @current_user
      unless picture&.update(permitted_params)
        render json: { errors: picture&.errors&.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: 'Unauthorized' }, status: :unauthorized
    end
  end

  def add_or_delete_user
    if picture&.owner == @current_user
      if user_exist_in_picture?
        picture.users.delete(user)
        picture.save
        render json: { message: 'User Deleted' }
      else
        picture.users.push(user)
        picture.save
        render json: { message: 'User Added' }
      end
    else
      render json: { message: 'Unauthorized' }, status: :unauthorized
    end
  end

  ## ADD POLICY TO CHECK IF I CAN ADD A PICTURE ONLY ON MY OWNED ALBUM
  def add_or_delete_album
    if picture&.owner == @current_user
      if picture_exist_in_album?
        picture.albums.delete(album)
        picture.save
        render json: { message: 'Picture Deleted' }
      else
        picture.albums.push(album)
        picture.save
        render json: { message: 'Picture Added' }
      end
    else
      render json: { message: 'Unauthorized' }, status: :unauthorized
    end
  end

  def destroy
    if picture&.owner == @current_user
      unless picture&.destroy
        render json: { errors: picture&.errors&.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: 'Unauthorized' }, status: :unauthorized
    end
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
