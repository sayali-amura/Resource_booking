require 'faker'
# has_many :roles, dependent: :destroy
# 	has_many :resources, dependent: :destroy
# 	has_many :employees, dependent: :destroy
# 	has_many :bookings, dependent: :destroy
# 	has_many :complaints, dependent: :destroy

FactoryGirl.define do
	factory :company do 
		name {Faker::Company.name}
		email {Faker::Internet.email}
		phone {"+91" << Faker::Number.number(10)}
		start_time {Faker::Time.between(DateTime.now - 3, DateTime.now - 2)}
		end_time {Faker::Time.between(DateTime.now - 1, DateTime.now)}
		after(:create) do |company|
			role_array = create_list(:role, 3, company: company)
			resource_array = create_list(:resource, 10, company: company)
			employee_array = create_list(:employee, 10,company: company, manager: Employee.employees(company.id).sample, role: role_array.sample)
			#booking_array = create_list(:booking, 10, company: company, resource: resource_array.sample, employee: employee_array.sample)
			complaint_array = create_list(:complaint, 10,company: company, employee: employee_array.sample, resource: resource_array.sample)
		end


	end

end