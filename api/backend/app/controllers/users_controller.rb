# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.by_recently_created
    render json: @users, each_serializer: UserPreviewSerializer
  end

  def show
    @user = User.includes(:pictures, :albums).find_by(id: params[:id])
    render json: @user
  end

  def update
    return if @current_user.update(permitted_params)

    render json: { errors: @current_user.errors.full_messages }, status: :unprocessable_entity
  end

  def destroy
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
