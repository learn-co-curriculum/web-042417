---
title: User Models with passwords
type: lesson
duration: "1:25"
creator:
    name: Toneloke
    city: COMPTON
competencies: Server Applications
---


# User Models with passwords

### Objectives
*After this lesson, students will be able to:*

- Describe why encryption is important for sensitive data
- Explain how has_secure_password works
- Create a user model with has_secure_password & the appropriate attributes
- Save a user with an encrypted password
- Find a user by email & password

### Preparation
*Before this lesson, students should already be able to:*

- Build a rails app from scratch
- Create RESTful routes with corresponding actions in Rails controllers
- Create relationships between models in Rails
- Use partials and templates in views


## Intro - What is Authentication and Encryption? (15 mins)


#### Authentication

Today, we are going to learn about making our site more secure. Authentication is about making sure you know the identity of the person accessing your site and the data you store.  Essentially, it's about asking for passwords, or other proof of identity.  It doesn't guarantee anything - if your girlfriend knows your email password, they could "pretend" to be you on a website.  Authentication should be used whenever you want to know exactly who is using or viewing your site.  To know which user is currently logged-in, a website needs to store sensitive data - this data will, therefore, be *encrypted*.

#### Encryption

When we talk about passwords, the commonly used word is "encryption", although the way passwords are used, most of the time, is a technique called "hashing". Hashing and Encryption are pretty similar in terms of the processes executed, but the main difference is that hashing is a one-way encryption, meaning that it's very difficult for someone with access to the raw data to reverse it.  


|     | Hashing |	Symmetric Encryption -|  
|-----|---------|-----------------------|
|     |One-way function	| Reversible Operation |
|Invertible Operation? |	No, For modern hashing algorithms it is not easy to reverse the hash value to obtain the original input value |	Yes, Symmetric encryption is designed to allow anyone with access to the encryption key to decrypt and obtain the original input value |

Now, we'll see how to implement hashing in a Rails app.

## Demo: Implement hashing in a Rails app (20 mins)

> Note: The instructor will create an app and then show the encrypted password and how.

```bash
rails new password_example
cd password_example
subl .
```

To implement hashing in our app, we will use a gem called `bcrypt-ruby` :

```bash
gem 'bcrypt', '~> 3.1.2'
bundle
rbenv rehash
```

Now we can create a model called `User` :

```bash
rails g model User email password_digest
rake db:migrate
```

The field `password_digest` will be used to store the "hashed password", we will see what it looks like in a few seconds but know that the original password will never be stored.  The logic for hashing a password the right way would be quite long to implement manually, so instead, we will just add a method provided by `bcrypt-ruby` to enable all the hashing/storing the hash logic, and we will add a validation for the email:

In app/models/user.rb :

```ruby
class User < ActiveRecord::Base
 has_secure_password
 validates :email, presence: true, uniqueness: true
end
```

Now that we added this method `has_secure_password` to the user model, we can use two "virtual" attributes on the model, `password` and `password_confirmation`.

"has_secure_password" gives you:

- password hashing and salting
  - by the way, **salting** is when random data is used as additional input to a one-way function that hashes a password or passphrase
- authenticating against the hashed password
- password confirmation validation


Now, in a rails console, type:

```ruby
user = User.new
user.password = "password"
user.password_confirmation = "password"
user.email = "u1@email.com"
user.save
user.password_digest
```

The long string of characters returned when we call the method `user.password_digest` is the hashed password!  

##  Implement Secure Password Authentication - Codealong (40 mins)

Now that you've seen me do it, let's try it together. First, create a rails app:

```bash
rails new password_example
cd password_example
subl .
```

We will first need to install the bcrypt encryption gem. In our `Gemfile`, we add the line:

```
gem 'bcrypt', '~> 3.1.2'
```

Then in terminal:  

```bash
bundle
rbenv rehash
```

Now we can generate a User model with an email and pasword_digest.

```bash
rails g model User email password_digest
rake db:migrate
```

In "models/user.rb":  

```ruby
class User < ActiveRecord::Base
 has_secure_password
 validates :email, presence: true, uniqueness: true
end
```

...and generate a users controller:  

```
rails g controller users index new create
```

In "controllers/users_controller.rb":  

```ruby
class UsersController < ApplicationController
 def index
  @users = User.all
 end

 def new
  @user = User.new
 end

 def create
  @user = User.new user_params
  if @user.save
   redirect_to users_path
  else
   render 'new'
  end
 end

 private
   def user_params
    params.require(:user).permit( :email, :password, :password_confirmation)
   end

end
```
> Note: Might want to touch on strong params here.

Let’s update our routes to include our users.  

In "config/routes.rb":  

```
resources :users, only: [:new, :index, :create]
```

Then we update our views:

In "views/users/index.html.erb":

```erb
<h1> Users index </h1>
<% @users.each do |user|%>
  <%= user.email %>
  <%= user.password_digest %>
<% end %>
```

In "views/users/new.html.erb":

```
<h1>Sign Up</h1>
<%= form_for @user do |f| %>
  <% if @user.errors.any? %>
  <div class="error_messages">
    <h2>Form is invalid</h2>
    <ul>
      <% for message in @user.errors.full_messages %>
      <li><%= message %></li>
      <% end %>
    </ul>
  </div>
  <% end %>

  <div class="field">
    <%= f.label :email %>
    <%= f.text_field :email %>
  </div>
  <div class="field">
    <%= f.label :password %>
    <%= f.password_field :password %>
  </div>
  <div class="field">
    <%= f.label :password_confirmation %>
    <%= f.password_field :password_confirmation %>
  </div>
  <div class="actions">
    <%= f.submit %>
  </div>
<% end %>
```

In "views/application/layout.html.erb", at the top of our body section, add:  

```erb
<% flash.each do |name, message| %>
  <div class="flash-message flash-message-<%= name %>">
    <%= message %>
  </div>
<% end %>
```

> Note: Quickly explain flash messages in context of Rails. [http://guides.rubyonrails.org/action_controller_overview.html#the-flash]()

#### Sessions Controller

Now to allow the user to login and out, we will need to create a sessions controller:

```bash
rails g controller sessions new create destroy
```

Now we can create routes for this controller.  In "routes.rb" you should now have:

```ruby
root "users#index"
resources :users, only: [:new, :index, :create]

get 'login', to: 'sessions#new'
resources :sessions, only: [:new, :create, :destroy]
```

In "sessions_controller.rb" we'll need to add some logic to handle the user's input for email and password:  

```ruby
class SessionsController < ApplicationController
 def new
 end

 def create
  user = User.find_by_email(params[:email])
  if user && user.authenticate(params[:password])
    redirect_to root_path, notice: "logged in!"
  else
   flash.now.alert = "invalid login credentials"
   render "new"
  end
 end

 def destroy
  redirect_to root_url, notice: "logged out!"
 end

end
```

Let's go through this line by line: All the authentication logic happens in the create method, but notice, first, we try to find a record in the table users. The line after, if there is a user record and if the password sent through the form corresponds to the hashed password in the database, then it means all the credentials (email + password) are valid, otherwise, the else case will be executed and either the email or the password were invalid - the user would get a message 'invalid login credentials' and be redirected to the ```sessions/new``` endpoint.

**Note: Flash.now vs Flash**

```
flash.now[:message] = "Hello current action"
```
When you need to pass an object to the next action, you use the standard flash assign ([]=). When you need to pass an object to the current action, you use now, and your object will vanish when the current action is done.

Now we will need to add a login form:

In "views/sessions/new.html.erb":

```erb
<h1>Login</h1>
<%= form_tag sessions_path do %>
  <div class="field">
    <%= label_tag :email %>
    <%= text_field_tag :email %>
  </div>
  <div class="field">
    <%= label_tag :password %>
    <%= password_field_tag :password %>
  </div>
  <div class="actions"><%= submit_tag "Log in" %></div>
<% end %>
```

Now we can delete the extra templates

- sessions/create.html.erb
- sessions/destroy.html.erb
- users/create.html.erb

After all this, create a user via `localhost:3000/users/new`. Then,  checkout `localhost:3000/users` - you should see the email you've used and the hashed password.

Now, you can try to sign-in by going to `localhost:3000/sessions/new`, and if you enter the credentials that matched your created user, you should see a message on the next page "Logged in!"; otherwise, the `else` statement will have executed, and you'll see "invalid login credentials".

...and that is how to implement an authentication system in Rails!

> ***Note:*** _This lesson being already quite long and involving a lot of typing from the students, we deliberately omit the students practice._

## Conclusion (10 mins)
We've covered a lot! You now know what happens when a password is saved in a database and how to authenticate a user. At the moment, our Rails app does not "remember" that a user is authenticated, to implement this, we will need functions, which is the topic of the next lesson.

- Describe the difference between hashing and encrypting.
- Explain what `has_secure_password` does for your application.
