class PicturesController < ApplicationController
  def index
    @pictures = @current_user.pictures
    render json: @pictures, status: :ok
  end

  def show
    @picture = Picture.find_by(id: params[:id])
    if @picture&.owner == @current_user
      render json: @picture, :include => [:users, :albums], status: :ok
    else
      render json: {message: 'Unauthorized'}, status: :unauthorized
    end
  end

  def create
    @picture = Picture.new(permitted_params)
    if @picture.save
      @picture.users = [@current_user]
      @picture.save
      @picture.img.attach(params['picture'])
      render json: @picture, status: :created
    else
      render json: { errors: @picture.errors.full_messages },
            status: :unprocessable_entity
    end
  end

  def update
    @picture = Picture.find_by(id: params[:id])
    if @picture&.owner == @current_user
      unless @picture&.update(permitted_params)
        render json: { errors: @picture&.errors&.full_messages },
                status: :unprocessable_entity
      end
    else
      render json: {message: 'Unauthorized'}, status: :unauthorized
    end
  end

  def add_or_delete_user
    @picture = Picture.find_by(id: params[:id])
    if @picture&.owner == @current_user
      @user = User.find_by(id: params[:user_id])
      if user_exist_in_picture?(@picture, @user)
        @picture.users.delete(@user)
      else
        @picture.users.push(@user)
      end
      @picture.save
      render json: {message: "User Changed"}, status: :ok
    else
      render json: {message: "Unauthorized"}, status: :unauthorized
    end
  end

  def add_or_delete_album
    @picture = Picture.find_by(id: params[:id])
    if @picture&.owner == @current_user
      @album = Album.find_by(id: params[:album_id])
      if picture_exist_in_album?(@picture, @album)
        @picture.albums.delete(@album)
        @picture.save
        render json: {message: "Picture Deleted"}, status: :ok
      else
        @picture.albums.push(@album)
        @picture.save
        render json: {message: "Picture Added"}, status: :ok
      end
    else
      render json: {message: "Unauthorized"}, status: :unauthorized
    end
  end

  def destroy
    @picture = Picture.find_by(id: params[:id])
    if @picture&.owner == @current_user
      unless @picture&.destroy
        render json: { errors: @picture&.errors&.full_messages },
                status: :unprocessable_entity
      end
    else
      render json: {message: 'Unauthorized'}, status: :unauthorized
    end
  end

  private

  def permitted_params
    params.permit([:name, :description, :url])
  end

  def user_exist_in_picture?(picture, user)
    @picture = Picture.find_by(id: params[:id])
    @picture.users.find_by(id: params[:user_id])
  end

  def picture_exist_in_album?(picture, album)
    @picture = Picture.find_by(id: params[:id])
    @picture.albums.find_by(id: params[:album_id])
  end
end