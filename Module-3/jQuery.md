# More jQuery

<http://api.jquery.com/>

### Objectives

- Learn what jQuery is, and its purpose
- Review jQuery selectors
- Understand jQuery filters
- Understand jQuery chaining
- Make cool animations with jQuery!
- Use AJAX
- ToDo List Lab

### Overview

* Libraries v Frameworks & "what is jQuery?"
* Including jQuery correctly
* Selectors
* Manipulating the DOM
* Play with jQuery in JSFiddle and/or implement it in your Rock, Paper, Scissors.

 ---
>**Note:**    
	"jQuery is a fast, small, and feature-rich JavaScript library. It makes things like HTML document traversal and manipulation, event handling, animation, and Ajax much simpler for the lazy programmer."


---
### Get started with jQuery

	cd ~/Desktop
	mkdir jquery
	cd jquery
	touch index.html
	mkdir css
	mkdir js
	touch css/app.css
	touch js/app.js


### Including jQuery

You can use jQuery by simply applying the google hosted library into your index.html

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>


---
## Element selectors

Thus far, you have been used to using ```document.getElementBy...``` to select DOM elements. jQuery does this slightly differently.

Selectors work using a CSS like syntax. This return a collection or single DOM element reference, to further manipulate.

#### **Review the javascript way**

```javascript
var x = document.getElementById("demo");   // Get the element with id="demo"
x.style.color = "red";                     // Change the color of the element

var y = document.querySelectorAll('li');
for(i=0;i<y.length;i++){
	y[i].addEventListener('click', someFunc);
	}
```
#### **Review the jQuery way**

```javascript
$('#demo').css('color','red');

$('li').on('mouseover click', someFunc);
```
>NOTE: There is also a .each method that can be used on collections.


#### **ASK STUDENTS**

How do you select an element in jQuery?

```
$('elementToSelect')
```

or store it in a variable:

	var listItems = jQuery('li');

Or the shorthand:

	var $li = $('li');



> The **$** sign **doesn't** mean that you're rich (just yet)

#### Element, Descendant, Child, Multiple & First(pseudo) Selectors:

* $("element, #id or .class")
* $("#id **descendant**")
* $(".class > **child**")
* $("#id1**,** #id2**,** #id3")
* $("li :first") <----JQUERY FILTER

You can specify classes, ids, elements etc.

	$( '#header' ); // select the element with an ID of 'header'

	$( 'li' );      // select all list items on the page

	$( 'ul li' );   // select list items that are in unordered lists

	$( '.person' ); // select all elements with a class of 'person'



#### A few useful jQuery methods that will also help with selection:

* $("").first()
* $("").last()
* $("").prev()

>NOTE:  More on these when we look at trasversing the DOM

### JQuery Filters
Are used to refine the return of our selectors.

```javascript
---EXAMPLE---
$('p:last')
$('p:not('.class'))
```
**Basic Filters**

- :not(selector)
- :first
- :last
- :even
- :odd
- :contains('text') -Elements that contain the specified text as a param.



## DOM Manipulations
For a complete list please refer to the jQuery documentation <http://api.jquery.com/>

### Mouse Events
```
 .click()
 .dblclick()
 .hover()
 .mouseover()
 .mouseout()
```

### DOM Insertions
```
 .append()
 .appendTo()
 .text()
 .prepend()
 .prependTo()
```
### DOM Removal
```
 .empty()
 .remove()
 .unwrap()
```


### Class Attribute
```
 .addClass()
 .removeClass()
 .toggleClass()
```



##Lets begin using jQuery

To wait for the document to load before running the script

	$(document).ready(function(){

	});

Or the shorthand

	$(function(){

	});

Setters & Getters in JQuery

	// This is a setter
	$("h1").html("hello");

	// This is a getter
	$("h1").html();

Let's set up your index.html

	<!DOCTYPE html>
	<html>
	<head>
		<title>jQuery Demo</title>
		<link rel="stylesheet" type="text/css" href="css/app.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
		<script type="text/javascript" src="javascript/app.js"></script>
	</head>
	<body>


	</body>
	</html>

## Sliding panel effect

Create a button and a panel in index.html

	<div id="panel"></div>
	<button id="btn-slide">Slide panel</button>


Apply CSS to the panel in app.css


	#panel
	{
		background: #754c24;
		height: 200px;
		width: 150px;
		display: none;
	}

And write jQuery into app.js

	//When document is loaded
	$(function(){

		$('#btn-slide').click(function(){
			$("#panel").slideToggle("slow");
		});

	});

## Disappearing pane effect

Create a disappearing pane in index.html

	<div class="pane">
		<h3>Sample header</h3>

		<span class="delete">delete</span>

		<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
		tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
		quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
		consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
		cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
		proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>

	</div>

Now, in app.js

	// Disappearing panel effect
	$(".pane .delete").click(function(){
			$(this).parents(".pane").animate({opacity: 'hide'}, "slow");

	});

Break into groups of two. Create a cool effect using jQuery animate (5 mins)

Demo the effects (5 mins)

## DOM in jQuery

You can grab the first child of document.body like this

	$(document.body.children[0]);

Let's make the first element of the body slide

	$(document.body.children[0]).click(function(){
		$(this).slideToggle('fast');
	});

Let's create HTML elements using jQuery

In index.html

	<!-- Append a paragraph to all body's children -->

	<button id="append-p">Append a paragraph to elements</button>


In app.js

	// Append a paragraph to elements

	$('#append-p').click(function(){
		$(document.body.children).append("<p>Hello class!</p>");
	});

Try and make this button append to only the 2nd item in the document.body (3min)

`Note: The jQuery objects are always truthy, so use the length to check for the right condition`

To check if selections exist, check the length


	if ( $( '#nonexistent' ) ) {
	  // Wrong! This code will always run!
	}

	if ( $( '#nonexistent' ).length > 0 ) {
	  // Correct! This code will only run if there's an element in your page
	  // with an ID of 'nonexistent'
	}

If you can add elements, you can remove them as well (app.js)

	// Append a paragraph to elements

	$('#append-p').click(function(){

		if($(this).html() !== "Nice!"){
			$(document.body.children).append("<p class='.p'>Hello class!</p>");
			$(this).html("Nice!");
		}else{
			$('p').remove(":contains('Hello')");
			$(this).html("Removed!");
		}

	});

Using the $ function, you can create elements like (app.js):

	// Creating an element in jQuery

	$('<p>', {html: 'I load with the page', class: 'greet'}).appendTo(document.body);


## Chaining example

	// end method specifies that we are getting back to the original selection

	$(".pane").find("span").eq(0).html("Lol").end().end().find("h3").eq(0).html("Fun title");

## $.AJAX example

Let's do an AJAX request to load local files into our html document.
Create a test.txt file with random text.

	// AJAX demo

	(add below to index.html)
	<button id="abtn">Import text from file</button>
	<div id="div1"><h2>Let jQuery AJAX Change This Text</h2></div>

	(add to app.js)
	$("#abtn").click(function(){
        $("#div1").load("test.txt");
    });
Awesome! You are now familiar with JQuery
