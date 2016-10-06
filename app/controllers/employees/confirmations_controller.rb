class Employees::ConfirmationsController < Devise::ConfirmationsController
  # Remove the first skip_before_filter (:require_no_authentication) if you
  # don't want to enable logged users to access the confirmation page.
  skip_before_filter :require_no_authentication
  skip_before_filter :authenticate_employee!
  before_action :check, only: [:update]

  def check

    flag = 0
    if (params[:employee][:password].empty?)
        flash[:danger] = "password can not be blank"
        flag = 1
    elsif (params[:employee][:password] != params[:employee][:password_confirmation])
        flash[:danger] = "password and password_confirmation should match"
        flag = 1
    elsif (params[:employee][:password].length < 6)
        flash[:danger] = "password length should be atleast 6"
        flag = 1
    end
    if flag == 1
      redirect_to :back, params
    end 
  end 



  # PUT /resource/confirmation
  def update
    with_unconfirmed_confirmable do
      if @confirmable.has_no_password?
        @confirmable.attempt_set_password(params[:employee])
        if @confirmable.valid? and @confirmable.password_match?
          do_confirm
        else
          do_show
          @confirmable.errors.clear #so that we wont render :new
        end
      else
        @confirmable.errors.add(:email, :password_already_set)
      end
    end

    if !@confirmable.errors.empty?
      self.resource = @confirmable
      render 'devise/confirmations/new' #Change this if you don't have the views on default path
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    with_unconfirmed_confirmable do
      if @confirmable.has_no_password?
        do_show
      else
        do_confirm
      end
    end
    unless @confirmable.errors.empty?
      self.resource = @confirmable
      render 'devise/confirmations/new' #Change this if you don't have the views on default path 
    end
  end

  protected

  def with_unconfirmed_confirmable
    original_token = params[:confirmation_token]
    @confirmation_token = params[:confirmation_token]
    #confirmation_token = Devise.token_generator.digest(Employee, :confirmation_token, original_token)
    @confirmable = Employee.find_or_initialize_with_error_by(:confirmation_token, @confirmation_token)
    if !@confirmable.new_record?
      @confirmable.only_if_unconfirmed {yield}
    end
  end

  def do_show
    original_token = params[:confirmation_token]
    @confirmation_token = params[:confirmation_token]
   # confirmation_token = Devise.token_generator.digest(Employee, :confirmation_token, original_token)
    @confirmable = Employee.find_or_initialize_with_error_by(:confirmation_token, @confirmation_token)
    @requires_password = true
    self.resource = @confirmable
    render 'devise/confirmations/show' #Change this if you don't have the views on default path
  end

  def do_confirm
    @confirmable.confirm
    set_flash_message :notice, :confirmed
    sign_in_and_redirect(resource_name, @confirmable)
  end
end