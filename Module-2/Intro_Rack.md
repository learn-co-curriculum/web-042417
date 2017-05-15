---
title: Rack from scratch
type: Lecture
duration: "1hr"
creator:
    name: Tony Guerrero
    city: NYC
competencies:  HTTP and Servers w/Ruby 
---


#What the Rack?


### Learning Objectives

- What is Rack
- Build your first Rack application
- Middleware
- Response / Request Objects
- Matching the path

| **Section** | **Timing** | **Description**                                            |
|-------------|------------|------------------------------------------------------------|
| Opening     | 5 mins    | What is Rack                                |
| I Do        | 10 mins    | First Rack app                                      |
| I Do        | 5 mins    | Using middleware  |
| You Do       | 5 mins    | Create everything I just did                                      |
| I Do         | 10 mins    | The response object & Render html.erb                                    |
| I Do         | 5 mins    | The request object                                     |
| I Do         | 10 mins    | Matching the path                                     |
| Closure     | 5 mins    | Review                                  

<br>

---


##Opening: What is "Rack" - 5 minutes
Rack is the underlying technology behind nearly all of the web frameworks in the Ruby world. "Rack" is actually a few different things:

- An architecture - Rack defines a very simple interface, and any code that conforms to this interface can be used in a Rack application. This makes it very easy to build small, focused, and reusable bits of code and then use Rack to compose these bits into a larger application.
- A Ruby gem - Rack is is distributed as a Ruby gem that provides the glue code needed to compose our code.
    

Rack defines a very simple interface. Rack compliant code must have the following three characteristics:

It must respond to `call`.
The call method must accept a single argument - This argument is typically called `env` or environment, and it bundles all of the data about the request.

The call method must return an array of three elements These elements are, **in order**, status for the HTTP `status code`, `headers`, and `body` for the actual content of the response.
A nice side effect of the call interface is that procs and lambdas can be used as Rack objects.    
<br>

---


##I Do: First Rack App - 10 minutes

####Directions:

We need to create a config.ru file which stands for rackup. This is like our run file in our CLI project.

```
touch config.ru
```


**Create a class called Montana w/ a call method**

```ruby
class Montana
  def call(env)
    [ 200, { "Content-Type" => "text/plain" }, ["Say hello to my little friend!"] ]
  end
end

run Montana.new
```

>Reminder: view the 'env' arg. 

In the sample we implement a class with a single instance method, call, that takes in the env and always returns a 200 (HTTP "OK" status), a "Content-Type" header, and the body of "Say Hello...".

Note that Rack expects the body portion of the response array to respond to each, so bare strings need to be wrapped in an array. More commonly, the body object will be some other type of IO object, rather than a bare string, so this wrapping is not needed in those cases.


We can now run our application by typing:
```
rackup config.ru
```

>Aside: We can respond with html by changing the content-type. 


```ruby
class Montana
  def call(env)
    [ 200, { "Content-Type" => "text/html" }, ["<h1>Say hello to my little friend!</h1>"] ]
  end
end

run Montana.new
```
##I Do: Middleware - 5 minutes

One of the things that makes Rack so great is how easy it is to add a chain middleware components between the webserver and the app to customize the way your request/response behaves. 


But what is a middleware component?

A middleware component sits between the client and the server, processing inbound requests and outbound responses. Why would you want to do that? There are tons of middleware components available for Rack that take the guesswork out of problems like enabling caching, authentication, trapping spam, and many other problems.

**Using middleware**:
To add middleware to a Rack application, all you have to do is tell Rack to use it. You can use multiple middleware components, and they will change the request or response before passing it on to the next component. This series of components is called the middleware stack.


```ruby
class Montana
  def call(env)
    Rack::Response.new("<h1>Say hello to my little friend!</h1>")
  end
end

use Rack::Reloader 0
run Montana.new
```

> The zero argument is cool down. By default it is 10 seconds.

We will be using something similar in Sinatra called shotgun its for more complex applications.

**Change the string and refresh your page**

##I Do: The "Response Object" - 5 minutes

####What is it?
_Rack::Response provides a convenient interface to create a Rack response.
It allows setting of headers and cookies, and provides useful defaults (an OK response with empty headers and body)._

```ruby
class Montana
  def call(env)
    Rack::Response.new("<h1>Say hello to my little friend!</h1>")
  end
end

use Rack::Reloader 0
run Montana.new
```
Who wants to write HTML in a string everytime?? `Luis!` That seems lame.. Tony is here to save the day. Copy pasta the below and lets render us some html... html.erb that is!

>Reminder: Explain what template engines are and why they are useful. 


###Templating 

Step 1:
```ruby
require "erb"
```

Step 2:

```ruby
#create the render method
def render(template)
  path = File.expand_path("./views/#{template}", __FILE__)
  ERB.new(File.read(path)).result(binding)
end
```

Step 3:

```mkdir views && touch views/index.html.erb```

or

```mkdir views; touch views/index.html.erb;```
for _fish shell_ (ask me later)

>Reminder: paste in HTML to index.html.erb from bootstrap or anywhere. 

Step 4:

```ruby
#putting it all together
require "erb"

class Montana
  def call(env)
    Rack::Response.new(render("index.html.erb"))
  end
end

#create the render method
def render(template)
  path = File.expand_path("./views/#{template}", __FILE__)
  ERB.new(File.read(path)).result(binding)
end

#middleware
use Rack::Reloader 0
run Montana.new
```


---

##You Do:  Repeat the above steps and try it on your own - 5 minutes

####Questions????




##I Do: The "Request Object" - 5 minutes

####What is it?
_Rack::Request provides a convenient interface to a Rack environment. It is stateless, the environment env passed to the constructor will be directly modified._

Lets take a look at what this object contains:

```ruby
class Montana
  def call(env)
    #create are res and req objects
    request  = Rack::Request.new(env)
    response = Rack::Response.new(request)
    #send the response
    response
  end
end
```

####What do you see?
Lots of stuff; `path`, `body` etc. What do you think we can do with the path?... 



...Why yes we could check for a specific match. GENIUSES I tell YOU.

```ruby
class Montana
  def call(env)
    #create are res and req objects
    request  = Rack::Request.new(env)
    #check for a matching path
    case request.path
      when "/" then Rack::Response.new(render("index.html.erb"))
      else Rack::Response.new("Not Found get out creep!", 404)
    end
  end
end
```

Congradulations! You made a rack application! As you can see there requires tons of setup to build this out. Think about how long my case statement could get if we were building a large application. No need to worry SINATRA is here! 

###Jimnalogy
![](https://cdn0.vox-cdn.com/thumbor/dmcYsUd4VInsNdVl9jEEO_KbjPw=/800x0/filters:no_upscale()/cdn0.vox-cdn.com/uploads/chorus_asset/file/8518019/not_hot_dog_app.png)

NOT HOT DOG IS A 404

## Closing - 5 mins 

####What did we learn?
- What is a ru file?
- What do I need for a Rack application to run?
- What is middleware?
- What is a template engine?
- A request object? A response object?


**Resources**:

http://www.rubydoc.info/gems/rack/Rack/
https://robots.thoughtbot.com/lets-build-a-sinatra
https://github.com/JoelQ/intro-rack-notes
http://gabebw.com/blog/2015/08/10/advanced-rack
https://www.youtube.com/watch?v=7u5TvA_l1wo#t=78.425416




