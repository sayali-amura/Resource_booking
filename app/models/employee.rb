#
# Class Employee provides functionality for managing employees related to company
#
# @author Amrut Jadhav  amrut@amuratech.com
#
class Employee 

  # include mongoid dependancies
  include Mongoid::Document
  include Mongoid::Timestamps


  # Devise options
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :trackable, :validatable, :confirmable

  # specify model fields
  
  field      :name, type: String
  field      :age, type: Integer
  field      :date_of_joining, type: DateTime
  field      :manager_id, type: BSON::ObjectId
  field      :role_id, type: BSON::ObjectId
  field      :created_at, type: DateTime
  field      :updated_at, type: DateTime
  field      :company_id, type: BSON::ObjectId
  field      :email, type: String


  field :encrypted_password, :type => String, :default => ""
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String
  
  ## Confirmable
  field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time
  field :unconfirmed_email,    :type => String # Only if using reconfirmable

  #
  # @!attribute [rw] skip_password_validation
  #   @return [Boolean] whether to skip password validation or not
  attr_accessor :skip_password_validation
  #
  # @!attribute [rw] skip_validation
  #   @return [Boolean] Whether to skip validation or not 
  attr_accessor :skip_validation

  # Associations
	belongs_to :role
	belongs_to :company
	has_many :bookings, dependent: :destroy
	has_many :complaints, dependent: :destroy
  # has_many :subordinates, class_name: "Employee", foreign_key: "manager_id"
  belongs_to :manager, class_name: "Employee"
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,   message: "email format" },
                       uniqueness:{scope: :company_id, message: "Email should be unique across the company"}
  validates :name, :email,:age, :role_id, :date_of_joining, presence: true
  validates :manager_id, presence: true, unless: :skip_validation
  validates :age, numericality: { only_integer: true, less_than: 2147483647, greater_than_or_equal_to: 1}, unless: :skip_validation
  validates :password, :password_confirmation, presence: {:message => 'no password'}, unless: :skip_password_validation

  # Callbacks
  before_save :lower_email

  
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
    Employee.where(manager_id:self.id)
    byebug
  end
  private

  #
  # Downcase the email and name of employee
  #
  #
  # @return [void] Downcase the fields
  # 
  def lower_email
   self.email.downcase!
   self.name.downcase!
  end

end
