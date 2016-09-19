# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)




Role.create([{designation: "Founder",department: "Company", priority: "1"},
	{designation: "Cofounder",department: "Company", priority: "2"},
	{designation: "Senior HR",department: "Human Resource", priority: "3"}])


Employee.create([{name: "hello",age:34,date_of_joining: 12/3/2012,manager_id:0,role_id:1,password:"123456",password_confirmation:"123456",email: "hello@gmail.com"},
	{name: "hi",age:29,date_of_joining: 12/3/2012,manager_id:1,role_id:2,password:"123456",password_confirmation:"123456",email: "hi@gmail.com"},
	{name: "a",age:23,date_of_joining: 12/3/2016,manager_id:2,role_id:4,password:"123456",password_confirmation:"123456",email: "a@gmail.com"},
	{name: "amrut",age:22,date_of_joining: 12/3/2016,manager_id:2,role_id:3,password:"123456",password_confirmation:"123456",email: "amrut@gmail.com"}])

# Employee.create([{}])