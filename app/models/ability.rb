#
# Class Ability provides abilities to employee
#
# @author Amrut Jadhav amrut@amuratech.com 
#
class Ability
  
  include CanCan::Ability

  #
  # Initialize method 
  #
  # @param [Employee] employee current_employee is passed to check its ability
  # 
  def initialize(employee)

    # If empty employee is nil intialize it with new Employee object
    employee ||= Employee.new

    # Check whether employee is existed in database or it is new?
    if !employee.new_record?
      company = employee.company
      
      admin_role_id = company.roles.find_by(designation: "admin").id
      if employee.role_id == admin_role_id      #Check whether employee is admin or regular employee
        can :manage, [Employee,Resource,Role]
        can [:read,:change_status], [Booking,Complaint]
        can [:manage], [Company]
      else        #If employee is regular employee
        cannot :change_status, [Booking,Complaint]
        can :manage, [Booking,Complaint] 
        can [:read,:index], [Resource]
        can [:entry], [Employee]
        cannot :manage, [Company]
      end
    else                                  # If employee is not existed in databse
      can [:entry], [Employee]
      can [:read], [Company] 
    end
  end
end
