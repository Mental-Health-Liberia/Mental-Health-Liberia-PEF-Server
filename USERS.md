# Users
The user management for the system is not ideal, but here is a document to explain how to do certain things.

## Standard User Functions
### User Creation
Users can be created by going to `/users/sign_up`. From there, the user's desired details can be filled out and the user will be created.

Users by default have no permissions.

### User Management
Users can be managed by going to `/users`. In order to have access to this page, you must have the `user_management` permission.

All of the user permissions can be added/removed here including:
 - Write API Access, i.e. can submit patient encounter forms
 - Read API Access, i.e. can use the read-only API
 - User Management Access
 - Configuration File Write Access, i.e. can change the configuration file (form layout)

### Signing In/Out
Users can sign in/out by going to `/users/sign_in` and `/users/sign_out` respectively.

Note: This only needs to be used by "admins", i.e. users with the `user_management` permission to access the user management page. It is otherwise unused.

## Initial Admin User
When you first set up the server, there will be no users. You must create the first initial user by going to `/users/sign_up` (see "User Creation" above).

However, since this user has no permissions, we need to add some. This must be done through the rails console.

```
$ rails console
Loading development environment (Rails 3.2.14)
irb(main):001:0> 
```

Once in the console, type `User.first`:
```
irb(main):001:0> User.first
=> #<User _id: 5288f4eb1205f96d6c000001, _type: nil, username: "tanner", encrypted_password: "$2a$10$VNJl/1HSp/qSGRthqQt7/OgFmcckHHUnFp.E/N7BWeoGzMrDbu3NK", email: "", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 31, current_sign_in_at: 2013-11-24 18:03:02 UTC, last_sign_in_at: 2013-11-24 18:03:02 UTC, current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", write_api: false, read_api: false, manage_users: false, modify_configuration:false>
```

The permissions we are looking for are at the very end:
```
write_api: false, read_api: false, manage_users: false, modify_configuration: false
```

We would like to give this user ("tanner") permission to manage users. Remember, this is only for the first initial user. In other scenarios, you can use the manage users page (see "User Management" above).

We do this but updating the attribute "manage_users" to true:
```
irb(main):002:0> User.first.update_attributes("manage_users"=>true)
=> true
```

The function returns true informing us that it returned successful. We can prove this by rerunning `User.first`:
```
irb(main):003:0> User.first
=> #<User _id: 5288f4eb1205f96d6c000001, _type: nil, username: "tanner", encrypted_password: "$2a$10$VNJl/1HSp/qSGRthqQt7/OgFmcckHHUnFp.E/N7BWeoGzMrDbu3NK", email: "", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 31, current_sign_in_at: 2013-11-24 18:03:02 UTC, last_sign_in_at: 2013-11-24 18:03:02 UTC, current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", write_api: false, read_api: false, manage_users: true, modify_configuration:false>
```

Once that is done, you can exit the console by entering `exit`.

You should now be able to go to the user management page (see "User Management" above) and login via this user.
