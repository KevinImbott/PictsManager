class UserPolicy
    def initialize
    end


    def show?
        true
    end

    def update?
      user.admin? || !post.published?
    end
  end