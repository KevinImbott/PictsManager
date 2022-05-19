class AlbumsController < ApplicationController
  def index
    @albums = @current_user.albums
    render json: @albums, status: :ok
  end

  def show
    @album = Album.find_by(id: params[:id])
    if @album&.owner == @current_user
        render json: @album, status: :ok
    else
      render json: {message: "Unauthorized"}, status: :unauthorized
    end
  end

  def create
    @album = Album.new(permitted_params)
    if @album.save
      @album.users = [@current_user]
      @album.save
      render json: @album, status: :created
    else
      render json: { errors: @album.errors.full_messages },
            status: :unprocessable_entity
    end
  end

  def update
    @album = Album.find_by(id: params[:id])
    if @album&.owner == @current_user
      unless @album&.update(permitted_params)
        render json: { errors: @album&.errors&.full_messages },
                status: :unprocessable_entity
      end
    else
      render json: {message: "Unauthorized"}, status: :unauthorized
    end
  end

  def destroy
    @album = Album.find_by(id: params[:id])
    if @album&.owner == @current_user
      unless @album&.destroy
        render json: { errors: @album&.errors&.full_messages },
                status: :unprocessable_entity
      end
    else
      render json: {message: "Unauthorized"}, status: :unauthorized
    end
  end

  private

  def permitted_params
    params.permit([:name])
  end
end