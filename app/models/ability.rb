class Ability
  include CanCan::Ability

  def initialize(employee)
    # Define abilities for the passed in user here. For example:
    #
# <<<<<<< HEAD
#    # alias_action :create, :read, :update, :destroy, :to => :crud
# =======
#     # alias_action :create, :read, :update, :destroy, :to => :crud
# >>>>>>> cd1d0b95f2ff4787e6695d86756b1fedd54864b0

      # byebug
      employee ||= Employee.new # guest user (not logged in)
# <<<<<<< HEAD
#       @company =employee.company
#       admin_role_id = @company.roles.find_by_designation("Admin").id
#       if employee.role_id == admin_role_id
#         can :manage, [Employee,Resource,Role]
#         can [:read,:change_status,:destroy], [Booking,Complaint]
# =======
      if !employee.new_record?
        company = employee.company
        admin_role_id = company.roles.find_by_designation("Admin").id
        if employee.role_id == admin_role_id
          can :manage, [Employee,Resource,Role]
          can [:read,:change_status], [Booking,Complaint]
        elsif employee.role_id > 0 && employee.role_id < company.roles.count        
          cannot :change_status, [Booking,Complaint]
          can :manage, [Booking,Complaint] 
          can [:read,:index], [Resource]
          can [:entry], [Employee]
        end
# >>>>>>> cd1d0b95f2ff4787e6695d86756b1fedd54864b0
      else
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
#7507897864
