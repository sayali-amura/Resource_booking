# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Company.create(name:"Amura",email:"amura@gmail.com",phone:"8765432123",start_time:9.0,end_time:18.0)
Resource.create(name:"conference_room_1",count:1,company_id:1,time_slot:1.0)

Role.create([{designation: "Founder",department: "Company", priority: "1",company_id:1},
	{designation: "Cofounder",department: "Company", priority: "2",company_id:1},
	{designation: "Senior HR",department: "Human Resource", priority: "3",company_id:1}])


Employee.create([{name: "hello",age:34,date_of_joining:" 2012-12-03",manager_id:0,role_id:1,password:"123456",password_confirmation:"123456",email: "hello@gmail.com",company_id:1},
	{name: "hi",age:29,date_of_joining: "2012-12-04",manager_id:1,role_id:2,password:"123456",password_confirmation:"123456",email: "hi@gmail.com",company_id:1},
	{name: "a",age:23,date_of_joining: "2016-12-03",manager_id:2,role_id:4,password:"123456",password_confirmation:"123456",email: "a@gmail.com",company_id:1},
	{name: "amrut",age:22,date_of_joining:"2016-12-5",manager_id:2,role_id:3,password:"123456",password_confirmation:"123456",email: "amrut@gmail.com",company_id:1}])
Booking.create(status:0,priority:0,feedback:"ok",comment:"hello",employee_id:1,date_of_booking:"Mon, 01 Jan -4712",resource_id:1,slot:1.0)
# Employee.create([{}])