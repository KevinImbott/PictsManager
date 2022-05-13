class PicturesController < ApplicationController
  def index
    @pictures = @current_user.pictures
    render json: @pictures, status: :ok
  end

  def create
    @picture = Picture.new(permitted_params)
    if @picture.save
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
      render json: {message: "Unauthorized"}, status: :unauthorized
    end
  end

  private

  def permitted_params
    params.permit([:name, :description, :url])
  end
end