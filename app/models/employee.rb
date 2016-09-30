class Employee < ActiveRecord::Base
	belongs_to :role
	belongs_to :company
	has_many :bookings
	has_many :complaints
	has_many :messages
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    message: "email format" }, uniqueness: true
    validates :name,:email, presence: true
    before_save :lower_email
  validates :role_id, :manager_id, numericality: { only_integer: true }
	
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :trackable, :validatable, :confirmable

# new function to set the password without knowing the current 
  # password used in our confirmation controller. 
  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end



  def password_required?
  	super if confirmed?
  end


  def password_match?
    self.password == self.password_confirmation
  end
 




  # new function to return whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end

  # Devise::Models:unless_confirmed` method doesn't exist in Devise 2.0.0 anymore. 
  # Instead you should use `pending_any_confirmation`.  
  def only_if_unconfirmed
    pending_any_confirmation {yield}
  end

  def self.edited_employee(employee_parameters,company)
    employee_parameters[:email]<<"@#{company.name}.com"
    employee_parameters
  end

  private
  def lower_email
	 self.email.downcase!
	end
end
