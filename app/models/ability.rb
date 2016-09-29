class Ability
  include CanCan::Ability

  def initialize(employee)
    # Define abilities for the passed in user here. For example:
    #
    alias_action :create, :read, :update, :destroy, :to => :crud

      employee ||= Employee.new # guest user (not logged in)
      @company =employee.company
      admin_role_id = @company.roles.find_by_designation("Admin").id
      if employee.role_id == admin_role_id
        can :manage, [Employee,Resource,Role]
        can [:read,:change_status], [Booking,Complaint]
      else
        can :manage, [Booking,Complaint] 
        cannot :change_status, [Booking,Complaint]
        can [:read,:index], [Resource]
        can [:entry], [Employee]
      end
    #
    # The first argument to `can` is the action you are giving the user

    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #

    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:

  end
end
