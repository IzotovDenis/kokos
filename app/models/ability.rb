class Ability

    include CanCan::Ability

    def initialize(user)
        @user = user || User.new
        if @user.id
            send(@user.role)
        end
    end

    def admin
        can :manage, Item
        can :manage, Group
        can :manage, Brand
    end

    def user
        can :read, Item
    end

end
