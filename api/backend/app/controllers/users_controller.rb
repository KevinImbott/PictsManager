# frozen_string_literal: true

class UsersController < AuthenticatedController
  def index
    @users = User.by_recently_created
    authorize @users
    render json: @users, each_serializer: UserPreviewSerializer
  end

  def show
    @user = User.includes(:pictures, :albums).find_by(id: params[:id])
    authorize @user
    render json: @user
  end

  def update
    authorize @current_user
    return if @current_user.update(permitted_params)

    render json: { errors: @current_user.errors.full_messages }, status: :unprocessable_entity
  end

  def destroy
    authorize @current_user
    @current_user.destroy
  end

  def profile
    render json: @current_user
  end

  private

  def permitted_params
    params.permit([:email, :pseudo, :password])
  end
end
