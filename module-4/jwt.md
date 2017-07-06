
# API Authentication with Express - Tokens

### Objectives
- Understand why authentication tokens are commonly used when interacting with APIs
- Add a token strategy to an application
- Authenticate a user based on their token

### Preparation

- Build a basic Rails API
- Understand foundational concepts in authentication & encryption

 
##The authentication problem
The HTTP protocol is _stateless_. This means the server does not remember anything about a client between requests. So if we authenticate a user with a username and password, then on the next request, our application won't remember us. 


The _old way_ of dealing with this was to store who was logged in on the server. Every time the server received a request from a client, it would check to see if that client was logged in or not. This is not very efficient:

1) Every time a user logs in, the server has to create a record somewhere on the server. If lots of users are logging in, the overhead on our server increases.

2) If the logged in information is stored in local memory on a server, the user will only be able to make requests to that server. This is not ideal - what if we have a bunch of servers, but most of the users are forced into using the original server they logged in at?

There are a few other problems, but these two are the main ones. 


## Tokens, The Basics - Intro (10 mins)
Token-based authentication is stateless. We are not storing any information about a logged in user on the server. No stored information means your applicaiton can scale and add more machines as necessary without worrying about where a user is logged in. 

Here is the JWT authentication flow:


	User requests access with username and password

					|
					|

	The app validates the credentials

					|
					|

	The app gives a signed token to the client

					|
					|

	The client stores the token and presents it with every request


## So what does a JWT look like?

Just three strings, separated by periods:

	aaaaaaaaaaaaaaa.bbbbbbbbbbbbbbbbbbbbb.ccccccccccccccccccc

The first part (aaaaaaaaaaaa) is the header

The second part (bbbbbbbbbbbb) is the payload - the good stuff, like who this person is, and their id in our database.

The third part (ccccccccccccc) is the signature. The signature is a hash of the header and the payload. It is hashed with a secret key, that we will provide.


Head on over to [jwt.io](http://jwt.io/#debugger) and see what I mean:

<img width="750" alt="JWTs" src="https://cloud.githubusercontent.com/assets/25366/9151601/2e3baf1a-3dbc-11e5-90f6-b22cda07a077.png">



#### Just like cookies, mmmm....

In the example above, you'll notice that there are 3 parts. The payload is the one we care the most about, and it holds whatever data we decide to put in there. It's very much like a cookie; we put as few things in there as possible – just the pieces we really need.

Applications can save a JWT somewhere on a user's computer, just like a cookie. Because JWTs can be encrypted into a single string, we can _also_ send it over HTTP really, really easily. Which means it'll work in any server/client scenario you can imagine. Quite nice.



## Let's PARTY ON CODE!

Let's take a few minutes to look at the rails api code.

What I want to do is limit our API so that you can only get the user data from it IF you have been authenticated. 

We will need to build a current_user/authenticate route that will check a user's password against the stored (and hashed) version in our database. If they match, our API will return a JWT. We then need to take that JWT and include it in all our later requests to prove that we are logged in. 




## Create a user

Open up rails console and get a user in there:

```ruby
User.create({username: 'toneloke',password:'dragons'})
```

## Authenticating a user and returning a JWT Server-Side

This authentication is going to take place in our auth controller and application controller file, where we previously said that authentication would take place. 

Let's first install the necessary JWT gem:


```
$ gem 'jwt'
```

We also need to provide a string that will serve as the secret signing key used in the hashing of the header and payload, to make up the third part of the JWT string

```
secret = "railsdragons"
```

The algorithim as well:

```
algorithm = "HS256"
```


>Explain JWT.encode && JWT.decode


Let's make sure we have all the required routes. Auth is where a user will send a POST request with a username and password. I.e. this is the route they will use to login. I guess we could have called it http://localhost:3000/api/v1/auth 

So let's write the machinery to generate a JWT and validate it:

Here's some pseudo-code of what I want to do - 

```ruby
class ApplicationController < ActionController::API
  private

  def issue_token payload
    JWT.encode(payload, secret, algorithm)
  end

  def authorize_user!
    if !current_user.present?
      render json: {error: 'No user id present'}
    end
  end

  def current_user
    @current_user ||= User.find_by(id: token_user_id)
  end

  def token_user_id
    decoded_token.first['user_id']
  end

  def decoded_token
    if token
      begin
        JWT.decode(token,secret, true, {algorithm: algorithm})
      rescue JWT::DecodeError
        return [{}]
      end
    else
      [{}]
    end
  end

  def token
    request.headers['Authorization']
  end

  def secret
    "railsdragons"
  end

  def algorithm
    "HS256"
  end
end

```


And here is what the auth controller should look like -

```ruby
class Api::V1::AuthController < ApplicationController
  before_action :authorize_user!, only: [:show]

  def show
    render json: {
      id: current_user.id,
      username: current_user.username
    }
  end

  def create
    # see if there is a user with this username
    user = User.find_by(username: params[:username])
    # if there is, make sure that they have the correct password
    if user.present? && user.authenticate(params[:password])
      # if they do, render back a json response of the user info
      # issue token
      created_jwt = issue_token({id: user.id})
      render json: {username: user.username,jwt: created_jwt}
    else
      # otherwise, render back some error response
      render json: {
        error: 'Username or password incorrect'
      }, status: 404
    end
  end
end
```

## Authenticating a user and sending a JWT Client-Side

Lets take a few minutes to checkout what was given to us on the client.

>Explain local storage.


```
localStorage.getItem('key')
localStore.setItem(object)
```

> View in application to in dev tools

Now lets write the code for the authAdapter, what should this class do for us?

>static anyone?

Here is the completed code:

```javascript
const baseUrl = 'http://localhost:3000/api/v1'

export default class AuthAdapter {
  static login (loginParams) {
    return fetch(`${baseUrl}/auth`, {
      method: 'POST',
      headers: headers(),
      body: JSON.stringify(loginParams)
    }).then(res => res.json())
  }

  static currentUser () {
    return fetch(`${baseUrl}/current_user`, {
      headers: headers()
    }).then(res => res.json())
  }
}

function headers () {
  return {
    'content-type': 'application/json',
    'accept': 'application/json',
    'Authorization': localStorage.getItem('jwt')
  }
}
```

Our App.js will contain the main logic for `login` `logout` and checking for a logged in user.

#### Login

```javascript

  logIn(loginParams){
    Auth.login(loginParams)
      .then( user => {
        if (!user.error) {
          this.setState({
            auth: { isLoggedIn: true, user: user}
          })
          localStorage.setItem('jwt', user.jwt )
        }
      })
  }
  
```
  
  
#### Logout

```javascript
  logout(){
    localStorage.removeItem('jwt')
    this.setState({ auth: { isLoggedIn: false, user:{}}})
  }
  
  //Navigation.js
  <Menu.Item name='logout' onClick={logout} />
```

Next we want to grab and validate the user on initiale mount. Lets add:

```javascript
componentWillMount(){
      if (localStorage.getItem('jwt')) {
       Auth.currentUser()
         .then(user => {
           if (!user.error) {
             console.log("fetch user");
             this.setState({
               auth: {
                 isLoggedIn: true,
                 user: user
               }
             })
           }
         })
     }
   }
```

### Authorization

I want to restrict users from going to the cards or home page unless the are logged in.

There are a few different ways I can do this. For now we will stay away from HOCs.

First method using Redirect component:

```jsx
<Route exact path='/' render={()=>{
return this.state.auth.isLoggedIn ? <Home /> : <Redirect to="/login"/>
}} />
```
Second method using browser history component:

**App.js**

```jsx
import createBrowserHistory from 'history/createBrowserHistory'

const history = createBrowserHistory()

<Router history={history}>
```

>explain how all route components now have this.props.history

**CardList.js**

```jsx
  componentWillMount () {
    console.log('Mounting')
    if (!localStorage.getItem('jwt')) this.props.history.push('/login')
  }
  componentWillUpdate () {
    console.log('Updating')
    if (!localStorage.getItem('jwt')) this.props.history.push('/login')
  }
```

##Conclusion

- What is a JWT? Why is useful for authorizing an API?
- How do you create a JWT?
- How do you secure a react component?
