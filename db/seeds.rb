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

# Employee.create([{}])