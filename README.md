

### Tables

* companies
```sh
id
name
address
```


* resources
```sh
id
name
count
company_id		=> foreign key of company
```

* employees
```sh
id
name
email
password
doj
role_id
manager_id		=>	employee id of manager
company_id		=> foreign key of company
```

* roles
```sh
id
designation	
department		=>	dept in company
priority		
company_id		=> foreign key of company
```
* complaints
```sh
id
owner_id		=> 	employee id who files complain
comment
status
resource_id	=> foreign key of resources
```

* bookings
```sh
id
owner_id		=> employee id
status			=> status of booking.   
    expected values=	[0=request,	1=grant,	2=reject,	3=release ]
priority		=> define priority of booking. 
    expected values=	[0=high,	1=medium,	2=low]
duration		=> total booking duration
timestamp		=> booking timestamp
comment		=> additional comments for booking. Also used to decide priority of booking.
shift			=> to check whether booking is shifted or not
feedback		=> feedback about resource use
company_id		=> foreign key of company
```

* messages
```sh
id
sender_id		=> foreign key of employee 
receiver_id
content	
booking_id		=> foreign key of booking
company_id		=> foreign key of company
```



# Relations

* Companies
```sh
1) Company has_many employees
2) company has_many resources
3) company has_many bookings
4)company has_many roles
```

* employees
```sh
1) employee belongs to company
2) employee belongs to role
3) employee has_many booking
4) employee has_one manager(i.e. employee)(self join)
5) employee has_many complaints
6) employee has_many messages
```

* bookings
```sh
1) booking belongs to employee
2) booking belongs to company
```

* complaints
```sh
1) complaint belongs to employee
2) complaint belongs to company
```

* messages
```sh
1) message belongs to booking
2) message belongs to employee

```
* resources
```sh
1) resource belongs to company

```
* roles
```sh
1) role has many employee
2) role belongs to comapny
```

# ROLES

* employee(regular)
```sh
1) request resource [conference room, projector, company car ] to HR
2) complain against resources [fan, AC, coffee etc] to HR
3) release resource
4) provide feedback about resource
```

* employee(HR)
```sh
1) grant/reject request for resource to employee
2) shifting resource allocation timing
3) update resources
4) add employees. (also assign manager)
```


# dashboard(VIEW)

* employee
```sh
1) history of actions
2) future resource allocation timetable (i.e calender)
3) notification regarding resource state
4) info  
```

* HR
```sh
1) resource requests
2) resource stats
```



# Model
```sh 
/Company
/Resource
/Employee
/Role 
/Complaint
/Booking
/Message
```


# Controller
```sh
/CompanyController
/employee/admincontroller
/employee/employeecontroller
```

# view
```sh
/company
/employee/admin/
/employee/employee/
```

# routes
```sh
root employee#index	(loginpage)
```

