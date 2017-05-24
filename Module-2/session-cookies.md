---
title: Sessions / Logging in by hand
type: lesson
duration: "1:25"
creator: Tony Guerrero
competencies: Server Applications
---



# Sessions/Logging in by hand

### Objectives
*After this lesson, students will be able to:*

- Explain the idea of being "logged in"
- Describe how a cookie works with user sessions and which users are "logged in"
- Create a cookie with a user's ID
- Create a form that on looks up a user & creates a cookie
- Write a helper for logged_in? & current_user to find a user by the ID in the cookie
- Log out a user by deleting a cookie
- Give access to specific routes only to logged users

### Preparation
*Before this lesson, students should already be able to:*

- Create a rails app
- Explain HTTP request/response
- Explain how to retrieve a user based on an email/password

##Intro - It's all about sessions (10 mins)

During the previous lesson, we've covered how to store critical data like passwords and how to know if a user is providing the right credentials; but this is the logic to authenticate a returning user who's will enter their credentials and create a new record for a new user.  How do we keep track of the state of every user and make sure they don't have to authenticate each time they visit?

The most common way of handling authentication - if all users are logged in or not - is to use cookies.

According to royal.gov.uk:

> "A cookie is a simple text file that is stored on a computer or mobile device by a website’s server and only that server will be able to retrieve or read the contents of that cookie. Each cookie is unique to a web browser, means that if you're logged in on Google with Chrome, you will still have to login to google if you open firefox on the same computer. Cookies will contain some anonymous information such as a user ID and the site name. It basically allows a website to remember things like user preferences or the content of a shopping basket."

## Demo/Codealong - How to use Cookies (15 mins)

> Note: Point out that students can try to follow along via a code along if they want, but that we'll be moving fast and starter code will be provided for the final activity.  It might be better for students to closely pay attention and ask any concept-related questions.

To illustrate how cookies are written and read from/by the server, let's create a rails app:

```bash
rails new cookies_example
cd cookies_example
subl .
```


Now we are going to create a controller `cookies` with 3 methods:

```bash
rails g controller cookies example_1 example_2 example_3
```

Open the controller, and in the three methods, add:

```
class CookiesController < ApplicationController
  def example_1
  	cookies[:user_name] = "david"
  end

  def example_2
  	cookies[:reference_to_keep_for_a_while] = { value: "XJ-122", expires: 1.year.from_now }
  end

  def example_3
  	puts cookies.inspect
  	cookies.delete :user_name
  end
end

```

So we have the methods `example_1` and `example_2` setting cookies, while the method `example_3` will print the object `cookies`- **provided by [ActionController](http://guides.rubyonrails.org/action_controller_overview.html#cookies)** - in the Rails logs and delete the cookie that we've set in the method `example_1`

Launch the server:

```bash
rails s
```

...and then, before opening localhost:3000 in the server, open the chrome dev tools and go to the tab "resources".  On the left side of the panel, select cookies and localhost.  Be aware that some cookies from other Rails application will appear, as cookies are shared for each domain.

If you go to `/cookies/example_1`, you will see that a cookie called "user_name" with a value "david". Because we haven't set any expiration time for this cookie, by default it will last for the current session, until the browser is closed or the machine is turned off.


Now go to `/cookies/example_2`, this action is adding another cookie "reference_to_keep_for_a_while", but check the column "expires" in the chrome dev tools, this one mention a specific time: this is because we said so when we've set it with the key `expires` in the hash:

```ruby
cookies[:reference_to_keep_for_a_while] = { value: "XJ-122", expires: 1.year.from_now }
```

Regardless of the browser being turned off or anything that can happen, this cookie will stay set for this website for a year.

In the third method `/cookies/example_3`, we print the content of the cookies on the server and then we delete a cookie called `:user_name`


Cookies can be set on both the client and the server side, and they can be read by both, too.  Remember, they are used to keep the state of a user through many requests.

## Cookies Recap - Discussion (5 mins)

> Note: Since this is a long Demo/Codealong (if you choose to make it a Codealong).  Take five minutes to pause and ask some questions that will check for student understanding and slowly review or re-explain topics that students may have missed.

## Demo/Codeaong - Implement session using cookies (25 mins)

- Give out starter-code

> Note: Point out that students can try to follow along via a codealong if they want, but that we'll be moving fast and starter code will be provided for the final activity.  It might be better for students to closely pay attention and ask any concept-related questions.

There is a specific cookie called the "session cookie" - this one is set by the server and we can add and remove keys/values to it.  It works in a specific way, as the whole cookie will be encoded for every request so that the data is not directly accessible on the client side.

At the moment, if you sign in with valid credentials, you will see a message saying that you are logged in, but in fact, the website will not remember that you are logged in the next time you reload the page.  To enable this, we need to store a value (a flag) in the session to tell Rails that the user requesting a page is the user X or Y. We will store the user id of the logged in user in the session cookie.

This will happen when a user successfully logs-in:

In `app/controllers/sessions_controller.rb`, go in the method create and add:

```ruby
if user && user.authenticate(params[:password])
   session[:user_id] = user.id
   redirect_to root_path, notice: "logged in!"
  else
   .....
```

The line `session[:user_id] = user.id` will store the user id in the cookie so that we can easily retrieve it for the next requests.  Now, the app is able to say for every request if the client is authenticated or not.

It would  be great to have two methods, one giving information about the status of the current request user and another one giving back the user object corresponding to the user id stored in the cookie. So let's do it...in `app/controllers/application_controller.rb`:

```ruby
class ApplicationController < ActionController::Base

  helper_method :current_user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

end
```

The first method `current_user` will return a user object if there is a user_id in the session cookie or will return `nil`.

The syntax `||=` means that if the instance variable on the left of the sign is anything different than `nil`, the return value from `User.find(session[:user_id])` will be assigned, otherwise, the original value assigned to the variable will be kept. We call this 'conditional assignment'.  The second method `logged_in?` will always return a boolean - this is  why we use a `?` in the method name - and will just convert the value returned by `current_user` to a boolean.

Because these methods are in the `ApplicationController` and all the controllers in our app inherit from `ApplicationController`, we will now be able to use them in all controllers.


At the top of controller, there is the line `helper_method :current_user`, this means that we can call the method `current_user` in the views. This is really helpful to show information about the user in the views.  For example, if a user is on their profile, you could add a conditional displaying an 'Edit Your Profile' link if the user viewing the page is the current user.

Now we should probably show some information in the layout,  and we'll be able to change this this information depending on if user is logged-in or not. If the user is logged, in we will show a welcome message with the user email and a link to log-out, otherwise we will show two links, one for sign-in and another one for sign-up.

In the layout, before the `<%= yield %>`, add:

```erb
<% if current_user %>
  <p> hello, <%= current_user.email %> </p>
  <%= link_to 'Logout', sessions_path, method: :delete, data: {confirm: 'Are you sure?'} %>
<% else %>
  <%= link_to 'Please login', login_path %>
<% end %>
```

The logout link will go to the method destroy in the `SessionsController`, and in this method, we will remove the `user_id` value in the cookie session:

```ruby
def destroy
  session[:user_id] = nil
  redirect_to root_url, notice: "logged out!"
end
```

We'll need to add a custom path to access this route without an id in the url (the classic path here will be /sessions/:id but we don't need an id) so add to `routes.rb.`:

```
delete "/logout", to: "sessions#destroy"
```

And update the view to be:

```
<%= link_to 'Logout', logout_path, method: :delete, data: {confirm: 'Are you sure?'} %>
```

- If your browser is still making a GET request, turn of Chrome and then turn back on again.

#### Restrict access to some data

The goal of authentication is to give us the ability to restrict access to some routes and data for non-authenticated users.  This can be done by creating a method that will check if the request is made by an authenticated user and redirect to the login path if not. Then using the Rails logic, we can execute this method for only the routes that we want to protect from non-authenticated users.

In `application_controller.rb`, at the bottom, add:

```ruby
  def authenticate
    unless logged_in?
      flash[:error] = "You must be logged in to access this section of the site"
      redirect_to login_url
    end
  end
```

The method `authenticate` will check if the user is logged in using the method `logged_in?` - if the value returned by this method is false, then we set a flash message to explain to the user what happened and why he/she can't go to this route and redirect to the login path.

Now, when we want to restrict access to some routes, we will call this method before the one in the controller.  Rails provide some helpers that will make this logic really easy to setup.

As an example, we will create a controller `secretController` with two methods `public_info` and `secret`:


```ruby
rails g controller secret public_info secret
```

...and then add this code the controller methods:

```ruby
class SecretController < ApplicationController
  before_action :authenticate, only: :secret

  def public_info
  	render text: "You can see this text because the controller method is not protected by a before_action in the controller"
  end

  def secret
  	render text: "You can only see this text when you are logged in because this method in the controller is protected by a before_action"
  end
end
```

The `before_action` will execute the method corresponding to the name passed as an argument, in this case the method ":authenticate", but it will only do it for the controller method secret, because we've explicitly said so with the key `only: :secret` in the `before_action`.

Now, make sure you are NOT logged in and then try to go to `/secret/public_info` and `/secret/secret`.  When you try to go to the second one, you are redirected to the login path with a message "You must be logged in to access this section of the site" as set in the authenticate method.

And this is how you can restrict access to some resources!


## Independent Practice (20 minutes)

> ***Note:*** _This can be a pair programming activity or done independently._

Using the [starter code](starter-code), create a controller `pages` with three different methods "everyone", "logged_in" and "logged_out".

The method "everyone" should be accessible for every visitor, the method logged_in should be accessed only by the people that are logged_in, and the method logged_out can only be accessed for users **NOT** logged_in.

Tip: You can have several before_action per controller.

## Conclusion (5 mins)
- What are cookies?
- Explain how to set cookies in a Rails application.
- Why is authentication important for Web apps?
