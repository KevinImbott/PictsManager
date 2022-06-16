class PicturePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  attr_reader :user, :picture

  def initialize(user, picture)
    @user = user
    @picture = picture
  end

  def create?
    true
  end

  def show?
    picture.users.include?(user)
  end

  def update?
    picture.owner == user
  end

  def add_or_delete_user?
    picture.owner == user
  end

  def add_or_delete_album?
    picture.owner == user
  end

  def destroy?
    picture.owner == user
  end
end
