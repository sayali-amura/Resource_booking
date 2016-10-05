class Employee < ActiveRecord::Base

  attr_accessor :skip_password_validation

	belongs_to :role
	belongs_to :company
	has_many :bookings
	has_many :complaints
	
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,   message: "email format" }, uniqueness: true
  validates :name, :email,:age, :role_id, :manager_id, :date_of_joining, presence: true
  validates :role_id, :manager_id, :age, numericality: { only_integer: true, less_than: 2147483647, greater_than: 1}
  validates :password, :password_confirmation, presence: {:message => 'no password'}, unless: :skip_password_validation
  before_save :lower_email	
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :trackable, :validatable, :confirmable

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

  private
  def lower_email
	 self.email.downcase!
   self.name.downcase!
	end
end
