class HomePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where.not(owner_id: user.id)
    end
  end

  attr_reader :user, :picture

  def initialize(user, picture)
    @user = user
    @picture = picture
  end
end
