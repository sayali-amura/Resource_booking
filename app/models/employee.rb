#
# Class Employee provides functionality for managing employees related to company
#
# @author Amrut Jadhav  amrut@amuratech.com
#
class Employee < ActiveRecord::Base

  #
  # @!attribute [rw] skip_password_validation
  #   @return [Boolean] whether to skip password validation or not
  attr_accessor :skip_password_validation

  # Associations
	belongs_to :role
	belongs_to :company
	has_many :bookings, dependent: :destroy
	has_many :complaints, dependent: :destroy
  has_many :subordinates, class_name: "Employee", foreign_key: "manager_id"
  belongs_to :manager, class_name: "Employee"
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,   message: "email format" },
                       uniqueness:{scope: :company_id, message: "Email should be unique across the company"}
  validates :name, :email,:age, :role_id, :manager_id, :date_of_joining, presence: true
  validates :role_id, :manager_id, :age, numericality: { only_integer: true, less_than: 2147483647, greater_than_or_equal_to: 1}
  validates :password, :password_confirmation, presence: {:message => 'no password'}, unless: :skip_password_validation

  # Callbacks
  before_save :lower_email

  # Devise options
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :trackable, :validatable, :confirmable

  scope :employees, -> id { where(company_id:id) }
  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end

  #
  # Check whther password is required or not
  #
  #
  # @return [Boolean] Whether password is required or not
  # 
  def password_required?
    super if confirmed?
  end

  #
  # Checks whether password and password_confirmation match?
  #
  #
  # @return [Boolean] Whether fields match or not
  # 
  def password_match?
    self.password == self.password_confirmation
  end
 
  #
  # Function to check whether password has been set or not
  #
  #
  # @return [Boolean] Whether the encrypted_password field is blank or not
  # 
  def has_no_password?
    self.encrypted_password.blank?
  end

  # Devise::Models:unless_confirmed` method doesn't exist in Devise 2.0.0 anymore. 
  # Instead you should use `pending_any_confirmation`.  
  def only_if_unconfirmed
    pending_any_confirmation {yield}
  end
  def manager
    Employee.find(self.manager_id)
  end
  def subordinates
    e = Employee.where(manager_id:self.id)
  end
  private

  #
  # Downcase the email and name of employe
  #
  #
  # @return [void] Downcase the fields
  # 
  def lower_email
   self.email.downcase!
   self.name.downcase!
<<<<<<< HEAD
	end
=======
  end
>>>>>>> 6f621bac91073b3cf8f78704725bd4fd4931637c

end
