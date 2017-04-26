---
title: Accessing third-arty APIs
type: lesson
duration: "1hr"
creator:
    name: Tony Guerrero
    city: NYC
competencies: API Endpoints, Third-party APIs 
---

# Accessing third-party APIs

### Objectives
*After this lesson, students will be able to:*

- Identify all the HTTP Verbs & their uses
- Describe APIs & how we'll cover them in the next unit
- Use a Ruby gem to access public APIs & get information back


## What is an API? (10 mins)



"An application-programming interface (API) is a set of programming instructions and standards for accessing a Web-based software application or Web tool. A software company releases its API to the public so that other software developers can design products that are powered by its service...[it] is a software-to-software interface, not a user interface. With APIs, applications talk to each other without any user knowledge or intervention."

__Great what does this mean?__

*Should we build google maps from scratch?*

Before the rise of API's when you went to a website they were mostly owned and operated by a single company. Now a website and display different pieces of data from across multiple companies. For example a webiste might use data from facebook to log you in, then display contents based on previous used websites and finally checkout and pay using paypal. Each one of these instances uses an API! 

>Remember these are programs that dont actually have **interfaces** they just act as the ethernet cord between the two. 

![](https://d1avok0lzls2w.cloudfront.net/img_uploads/apis-for-marketers.png)



## Introduction to the HTTP Protocol - Demo (15 mins)

**How do computers communicate?**

*Do they speak Binary? 1001001010*

HTTP allows for communication between a variety of hosts and clients, and supports a mixture of network configurations.

This makes HTTP a stateless protocol. The communication usually takes place over TCP/IP, but any reliable transport can be used. The default port for TCP/IP is 80, but other ports can also be used.

Communication between a host and a client occurs, via a request/response pair. The client initiates an HTTP request message, which is serviced through a HTTP response message in return. 

**URLs -**
At the heart of web communications is the request message, which are sent via Uniform Resource Locators (URLs). I'm sure you are already familiar with URLs, but for completeness sake, I'll include it here. URLs have a simple structure that consists of the following components:
![](https://cdn.tutsplus.com/net/authors/jeremymcpeak/http1-url-structure.png)

### Interacting with protocols

URLs reveal the identity of the particular host with which we want to communicate, but the action that should be performed on the host is specified via HTTP verbs. Of course, there are several actions that a client would like the host to perform. HTTP has formalized on a few that capture the essentials that are universally applicable for all kinds of applications.

These request verbs are:

 **GET:** fetch an existing resource. The URL contains all the necessary information the server needs to locate and return the resource.
 
**POST:** create a new resource. POST requests usually carry a payload that specifies the data for the new resource.

**PUT:** update an existing resource. The payload may contain the updated data for the resource.

**DELETE:** delete an existing resource.

### Response from the server
**Status Codes:**

With URLs and verbs, the client can initiate requests to the server. In return, the server responds with status codes and message payloads. The status code is important and tells the client how to interpret the server response. The HTTP spec defines certain number ranges for specific types of responses:

- 1xx: Informational Messages
- 2xx: Successful
- 3xx: Redirection
- 4xx: Client Error
- 5xx: Server Error

So far, we've seen that URLs, verbs and status codes make up the fundamental pieces of an HTTP request/response pair.

**But first JSON:**

JSON (JavaScript Object Notation) is a lightweight data-interchange format. It is easy for humans to read and write. It is easy for machines to parse and generate. It is based on a subset of the JavaScript Programming Language, Standard ECMA-262 3rd Edition - December 1999. JSON is a text format that is completely language independent but uses conventions that are familiar to programmers of the C-family of languages, including C, C++, C#, Java, JavaScript, Perl, Python, and many others. These properties make JSON an ideal data-interchange language.

```json
{ 
  status-code: 200,
  response: true,
  data: [{name: "Toneloke"},{name: "Esmery"}]
}

<XML>
 <STATUS-CODE>
  200
 </STATUS-CODE>
 'you get the point'
</XML>
```

![](https://cdn.tutsplus.com/net/authors/jeremymcpeak/http1-req-res-details.png)


## Use an API with Ruby - Codealong (15 mins)

We're going to write a Ruby script that uses a gem (`REST Client`) to execute HTTP requests getting **POKEMON** information as per a user's requests.

#### Pseudo code it


Let's install the `rest-client` gem, a library that makes is _super_ easy to request and handle responses from APIs:

```
gem install rest-client

```

Let's create a ruby file `pokeapi.rb`.  First of all, we're going to require the gem, so open the file and type:


```ruby
require "rest-client"

```

This script will always require the same domain (http://pokeapi.co/api/v2/), thus we will store this domain in a CONSTANT:

```ruby

require "rest-client"
URL = "http://pokeapi.co/api/v2/"

```

Let's play with the API and make a request to the search pokemon for "pikachu":

```ruby

require "rest-client"
require "pry"
require "json"
URL = "http://pokeapi.co/api/v2/"
binding.pry
result = JSON.parse(RestClient.get(URL+"pokemon/pikachu/"))
```
>SYMBOLS DO NOT WORK WITH PARSED HASHES

**Run it! What do you see?**

What if I didn't know the name of the pokemon I wanted? Lets try grabbing all of the pokemon and iterating through each one to find what we need.

YOU DO: Have the students make a request to the `/pokemon` resource path. 



## Conclusion (5 mins)
We've seen how to consume an API hosted on a server and interact with it using ruby. We will later see how to use an API with Rails, Node, and other frameworks.  Also, we will dive into creating an API and authenticate users through APIs.

- What is an API?
- How does cURL compare to a browser client?

>URIs are identifiers, and that can mean name, location, or both.
All URNs and URLs are URIs, but the opposite is not true.
The part that makes something a URL is the combination of the name and an access method, such as https://, or mailto:.
All these bits are URIs, so saying that is always technically accurate, but if you are discussing something that’s both a full URL and a URI (which all URLs are), it’s best to call it a “URL” because it’s more specific.
