class UserPolicy < ApplicationPolicy
    def initialize
    end


    def show?
      false
    end

    def update?
      user.admin? || !post.published?
    end
  end