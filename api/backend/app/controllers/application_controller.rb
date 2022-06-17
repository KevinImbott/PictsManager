# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include JsonWebToken

  rescue_from ActiveRecord::RecordNotFound do
    render json: { error: 'Not Found' }, status: :not_found
  end

  rescue_from Pundit::NotDefinedError do
    render json: { error: 'Not Found' }, status: :not_found
  end
  private

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(" ").last if header
    decoded = jwt_decode(header)
    @current_user = User.find(decoded['user_id'])
  end
end
