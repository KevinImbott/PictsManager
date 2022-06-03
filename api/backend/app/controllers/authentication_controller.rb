# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def signup
    user = User.new(permitted_params)
    if user.save
      token = jwt_encode(user_id: user.id)
      render json: { token: token }, status: :ok
    else
      render json: { message: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = jwt_encode(user_id: user.id)
      render json: { token: token }, status: :ok
    else
      render json: { message: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private

  def permitted_params
    params.permit([:email, :pseudo, :password])
  end
end
