class AuthenticationController < ApplicationController
  def signup
    user = User.new(permitted_params)
    # if user is saved
    if user.save
      # we encrypt user info using the pre-define methods in application controller
      token = encode_user_data({ user_id: user.id })
      # return to user
      render json: { token: token }
    else
      # render error message
      render json: { message: "Invalid credentials" }
    end
  end

  def login
    user = User.find_by(email: params[:email])
    # you can use bcrypt to password authentication
    if user&.authenticate(params[:password])
      # we encrypt user info using the pre-define methods in application controller
      token = encode_user_data({ user_data: user.id })
      # return to user
      render json: { token: token }
    else
      render json: { message: "Invalid credentials" }
    end
  end

  private

  def permitted_params
    params.permit([:email, :pseudo, :password])
  end
end