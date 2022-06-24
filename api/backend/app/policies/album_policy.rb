class AlbumPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(owner_id: user.id)
    end
  end

  attr_reader :user, :album

  def initialize(user, album)
    @user = user
    @album = album
  end

  def show?
    album.users.include?(user)
  end

  def update?
    album.owner == user
  end

  def add_or_delete_user?
    album.owner == user
  end

  def add_or_delete_album?
    album.owner == user
  end

  def destroy?
    album.owner == user
  end
end
