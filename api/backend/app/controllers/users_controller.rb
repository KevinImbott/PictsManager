# frozen_string_literal: true

class UsersController < AuthenticatedController
  def index
    users = User.all
    authorize users
    render json: handle_sort(users).paginate(page: params[:page]), each_serializer: UserPreviewSerializer
  end

  def show
    @user = User.includes(:pictures, :albums).find_by(id: params[:id])
    authorize @user
    render json: @user
  end

  def update
    authorize current_user
    return if current_user.update(permitted_params)

    render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
  end

  def destroy
    authorize current_user
    current_user.destroy
  end

  def profile
    render json: current_user, serializer: ProfileSerializer
  end

  private

  def permitted_params
    params.permit([:email, :pseudo, :password])
  end

  def handle_sort(users)
    return users if params[:pseudo].nil?

    users.where('pseudo ILIKE ?', "%#{params[:pseudo]}%") if params[:pseudo]
  end
end
