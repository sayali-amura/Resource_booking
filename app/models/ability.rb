class Ability
  include CanCan::Ability

  def initialize(employee)
      employee ||= Employee.new # guest user (not logged in)

      if !employee.new_record?
        company = employee.company
        admin_role_id = company.roles.find_by_designation("Admin").id
        if employee.role_id == admin_role_id
          can :manage, [Employee,Resource,Role]
          can [:read,:change_status], [Booking,Complaint]
          can [:manage], [Company]
        else        
          cannot :change_status, [Booking,Complaint]
          can :manage, [Booking,Complaint] 
          can [:read,:index], [Resource]
          can [:entry], [Employee]
        end
      else
        can [:entry], [Employee]
      end
  end
end
