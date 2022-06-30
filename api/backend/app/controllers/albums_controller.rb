# frozen_string_literal: true

class AlbumsController < AuthenticatedController
  def index
    albums = policy_scope(@current_user.albums)
    render json: albums.paginate(page: params[:page]), each_serializer: AlbumPreviewSerializer
  end

  def show
    authorize album
    render json: album
  end

  def create
    new_album = Album.new(permitted_params)
    if new_album.save
      new_album.owner = @current_user
      new_album.users = [@current_user]
      new_album.save
      render json: new_album, status: :created
    else
      render json: { errors: new_album.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def add_or_delete_user
    authorize album
    if user_exist_in_album?
      album.users.delete(user)
      album.save
      render json: { message: 'User Deleted' }
    else
      album.users.push(user)
      album.save
      render json: { message: 'User Added' }
    end
  end

  def update
    authorize album
    return if album&.update(permitted_params)

    render json: { errors: album&.errors&.full_messages }, status: :unprocessable_entity
  end

  def destroy
    authorize album
    return if album&.destroy

    render json: { errors: album&.errors&.full_messages }, status: :unprocessable_entity
  end

  private

  def permitted_params
    params.permit([:name])
  end

  def user_exist_in_album?
    album.users.find_by(id: user.id)
  end

  def album
    album ||= Album.find_by(id: params[:id])
  end

  def user
    user ||= User.find_by(id: params[:user_id])
  end
end
