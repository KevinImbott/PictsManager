class UsersController < ApplicationController

  def index
    @users = User.by_recently_created
    render json: @users, status: :ok
  end

  def update
    unless @current_user.update(permitted_params)
      render json: { errors: @current_user.errors.full_messages },
              status: :unprocessable_entity
    end
  end

  def destroy
    @current_user.destroy
  end

  def profile
    render json: @current_user, status: :ok
  end

  private

  def permitted_params
    params.permit([:email, :pseudo, :password])
  end
end
