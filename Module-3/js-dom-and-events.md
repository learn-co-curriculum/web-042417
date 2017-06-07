---
course: Full Stack JS
type: lesson
duration-in-hours: 1.25
competencies: Browser JavaScript
---

# DOM Manipulation & Events

### Objectives

- Understand what the DOM is
- Select elements from the DOM using selectors
- Create new elements and attributes programmatically
- Bind events to single and multiple DOM elements
- Create a listener for mouse and keyboard events and respond with an action

### Preparation
- Understand the basic structure of HTML
- Know how to make variables to hold information
- Know what a function is and how to create one

## What is the DOM? (20 mins)

The Document Object Model, or DOM, is an interface to interact with an HTML document. Think of it like a tree graph, where each element has children beneath it. For the following HTML (from `starter-code/index-01.html`), look at how we reconsider it as a graph:

```html
<!DOCTYPE html>
<html>
  <head>
    <title>
      Example
    </title>
  </head>
  <body>
    <h1>
      Example Page
    </h1>
    <p>
      This is an example page.
    </p>
  </body>
</html>
```
> _Open up starter-code/index-01.html_

![DOM Tree](http://www.computerhope.com/jargon/d/dom1.jpg)

While the whole thing is a _document_ (yeah, like a Microsoft Word document, but cooler), each of those children is a called _node_. There are _element nodes_, like `<h1>` or `<a>`; and the text inside those is considered a node, too, a _text node_. Any attributes on an element are also nodes.

- The document itself is a document node
- All HTML elements are element nodes
- All HTML attributes are attribute nodes
- Text inside HTML elements are text nodes
- Comments are comment nodes

There are a bunch of kinds of nodes, but the ones above are the ones you'll probably deal with most.

Now you can sort of see why developers care about indenting – it's actually a representation of the which nodes are inside of which nodes.

## Selecting Nodes with JavaScript (15 mins)

So what if we need to grab a certain part of our HTML document & do something with it? #JavaScript

Now, how do we get started – **what node is at the top of our graph above?**

> "Document Root!!!" _- Literally Everyone in the Room_

Exactly – that's why we start with `document`. Follow along in your browser console, and let's type the code as we go so we can all mess with an existing HTML document and see how it works.

```js
document.querySelectorAll("h2"); // One of many beautiful JS node selector functions
```

This one of many, we'll see, and it starts at the top of the DOM graph & selects all things that match our query – get us any H2's on the page.

We can be more specific with it if we want:
```js
document.querySelectorAll("h2#Summary"); // This gets any & all h2's with an ID of Summary
```

Or, we can be less specific, and grab a handful of things:

```js
document.querySelectorAll("h2#Summary, p, h1"); // This gets any & all h2's with an ID of Summary, p elements, and h1's
```

## Other Awesome Selectors (5 mins)

We've got a few other great functions that come with JS for selecting nodes, let's see:

```js
document.querySelectorAll("h2, #some-id, .some-class"); // grab elements using CSS selectors. returns an array
document.querySelector("h2, #some-id, .some-class"); // grab the first matching element, also using CSS selectors. returns a single node instead of an array
document.getElementsByTagName("p"); // grab elements by searching for an element tag. returns an array
document.getElementById("some-id"); // grab one specific element using its ID. returns a single node
document.getElementsByClassName("some-class"); // grab any elements that are using the specified class. returns an array
```

## You try it! (5 minutes)

Fire up some random site, open up your console, and use all of our new selectors to try nab some elements on the page. Go for unique IDs, classes, and elements – try 'em all.

## Interacting with Humans (15 mins)

Now, the wonderful thing about JS is being able to make your documents interactive. This'll make use of what you've learned about functions so far, and we'll see how to modify the DOM at the same time.

Let's start with some boilerplate HTML, open up `starter-code/index-02.html`:

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Exercise</title>
  </head>
  <body>
    <div id="div-1">
      I'm div #1
    </div>
    <div id="div-2">
      I'm div #2
    </div>
    <div id="div-3">
      I'm div #3
    </div>
    <div id="div-4">
      I'm div #4
    </div>
    <div id="div-5">
      I'm div #5
    </div>
  </body>
</html>
```

How do we grab `div-1`?

```js
// let's use el instead of element, because we're lazy & that's great
// because it returns an array, let's grab the first one
var el = document.querySelectorAll('#div-1')[0]

// addEventListener is a function that comes with JS to handle all sorts of events
el.addEventListener("click", function(){

    // let's modify some flipping DOM elements, yo
    el.innerHTML = "Hello World, I'm div #1";
});
```

There's a bit going on here, so let's break it down:

- Select a DOM element, store it in a variable so we can use it later
- add an eventListener to our newly found element
- listen for an event that's called "click"
- create a function (here, an _anonymous_ function) so we can do something when that happens
- grab our element, and modify it's DOM attributes


#### Wait, I have so many questions!
At this point, you might have a few questions, such as:
- _"Is the word 'click' made up or magic? How do I know what events are possible?"_
- _"Where did .innerHTML come from? How am I supposed to know what attributes I can change?"_

Luckily, there are answers to both of these things, which is a fun little thing we call "googling it." Just kidding. Sort of. Here are a few resources to let you know what events are available to you, and what attributes you can access and change in the DOM:

- W3's megalist of [HTML DOM Node Properties & Methods](http://www.w3schools.com/jsref/dom_obj_all.asp)
- MDN's even longer megalist of bajillions of [standard Javascript events](https://developer.mozilla.org/en-US/docs/Web/Events)

## You try it! (5 minutes)

Using our example page, play around in the console with making event listeners for all sorts of events. Have the list of events open and experiment with a couple, just to see what happens.

## Lastly, let's try creating a DOM object (15 mins)

We can just as easily create new nodes in our document, too.

```js
    // let's start constructing a sixth div
    // when creating elements, always start with document, and we'll add it where we want it later
    var div6 = document.createElement("div");

    // let's give it any attributes it needs and try to make it match the others
    div6.id = "div-6";
    div6.innerHTML = "I'm div #6";
    div6.style.color = "#81e8db";

    // finally, let's add it to the DOM where we want it to live
    // let's start by grabbing the body, cuz that's the parent of all the other divs we already have
    body = document.querySelectorAll("body")[0];

    // ahhhh, there's that magic. this function works on any any node, to add a new child! let's just give it the div we've been building inside that div6 variable
    body.appendChild(div6);

```

Oh snap, did you just add a div?! Nice work.

## Conclusion (5 mins)

- What are examples of DOM nodes will we be dealing most often?
- How can you grab an element with the ID of bagel?
- How do you change the text inside an element?
- How would you run a function for when something gets clicked?
s