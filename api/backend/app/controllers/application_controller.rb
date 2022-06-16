# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include JsonWebToken

  private

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(" ").last if header
    decoded = jwt_decode(header)
    @current_user = User.find(decoded['user_id'])
  end
end
