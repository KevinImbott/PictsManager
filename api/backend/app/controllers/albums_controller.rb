class AlbumsController < ApplicationController
  def index
    @albums = @current_user.albums
    render json: @albums, status: :ok
  end

  def show
    @album = Album.find_by(id: params[:id])
    if @album&.owner == @current_user
        render json: @album, :include => :users, status: :ok
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

  def add_or_delete_user
    @album = Album.find_by(id: params[:id])
    if @album&.owner == @current_user
      @user = User.find_by(id: params[:user_id])
      if user_exist_in_album?(@album, @user)
        @album.users.delete(@user)
      else
        @album.users.push(@user)
      end
      @album.save
      render json: {message: "User Changed"}, status: :ok
    else
      render json: {message: "Unauthorized"}, status: :unauthorized
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

  def user_exist_in_album?(album, user)
    @album = Album.find_by(id: params[:id])
    @album.users.find_by(id: params[:user_id])
  end
end