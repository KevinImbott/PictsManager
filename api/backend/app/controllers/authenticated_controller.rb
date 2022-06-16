# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  include JsonWebToken
  include Pundit

  before_action :authenticate_request

  helper_method :current_user

  private

  def current_user
    @current_user ||= authenticate_request
  end

  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(" ").last if header
    decoded = jwt_decode(header)
    @current_user = User.find(decoded['user_id'])
  end
end
