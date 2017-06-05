##Intro to Javascript

###What is Javascript?

The enemy of sane programmers? The answer to all problems in life? Ask enough developers, or read enough forum posts on the subject, and you will hear these answers. So which is it?......I won't answer that. What is important is the fact that Javascript is ubiquitous. It's everywhere, it's really powerful, and you need to know it....really, really know it.  

Javascript, from the browser perspective, encompasses three main areas: ECMAScript, the DOM, and the BOM. 

We will look at each in turn. 

###Does Javascript == Java? 

This can be confusing to those new to web programming, but its important to make a clear distinction between the two. Javascript and Java are in no
way the same thing and refer to completely different languages. The distinction between the two can help us understand and characterize javascript better. The main difference in appearance to the programmer is Types. 

##Types

A **type** in a programming language specifies a **kind of data**. While this might not be the most technical way to describe it, it's how we're
most likely to think about it. 

Javascript has five **primitive** types:

* String - characters or textual data..stuff like:  "abc", and "hello there 123"
* Number - just like it sounds..this is a number: 123 or 12.3
* Boolean - these are truthy or falsy values, or you could say 
* Null - has exactly one value which is : null . This is used to signify an empty value. 
* Undefined - usually this is a variable that hasn't been initialized: 'var x;' will result in x being undefined at this point.  
* Symbol - began as a way to create private private object members.


What does that mean...that they live in caves? No, in the context of Javascript we can think of them as being base line values.
Objects can have parts to them made up of strings, numbers, and booleans. There's more depth to this, but let's leave it at that for now. 

Javascript also has the notion of:

* Object

Objects are complex types with many properties and methods attached or 'built in' to them. An object can be thought of as a logical containment unit
for values, and functionality that will manipulate or provide access to those values. 

```javascript
var Car = {

  speed: 50,
  getSpeed: function(){
  
    return this.speed;
  } 
}
```
Above we've constructed a Car object that has a speed and a way to return the speed by making a function call. 

> Exercise: Write a function that returns the minimum of two numbers

####Typed vs Dynamic Languages (This title would be flame war bait if you posted it to a programming forum..maybe Hackers News)

So javascript has types...does that mean it is a 'typed language'.  No, javascript does not have a type system that
is exposed in the language syntax. In other words, there is no declaration on the part of the programmer that you can use
to be explicit about the the type a variable will hold. Let's see what this looks like. 

```javascript

//we declare a varible to hold the number 3...wait...
//doesn't that mean I'm giving that variable a type? 
var x = 3;

function add(a,b){

   console.log(a+b);
}

//how does 'the program' internally know what to 
//expect x to be..if x could be initialized with anything?
add(x,3);


```

The answer is: **It can't**. The value has to be **checked at runtime** to determine what it is. This is why we say
that a language like javascript is **dynamically checked**(note: people also refer to these languages as **dynamically typed**, but if you want to be
pedantic dynamically checked is accurate).

This runtime checking process is one of the reasons that a language like javascript is slower than a language that is
**statically typed** and **compile time checked**. What does that look like? Here's the same thing in C: 

```c

//declare x to be of type 'int' which mean integer,
//which is a type of number
int x = 3;

//here our function will return the added value, 
//we also have to start our function declaration
//with the type that will returned...which is an int
int add (int a , int b){

   return a+b;

}

//here we are just printing out the returned 
//value to the console..c has some funky syntax for that. 
cout << add(x,3);

```

By having a type system like in C above, we can tell the computer what types to expect exactly in advance, and in this
way we don't have to do it at runtime. Additionally, if you think about it, this also helps us as programmers
to avoid shooting ourselves in the foot. If we statically type the parameters our add function will have, if we try to, or accidentally
pass it a string...the compiler will yell at us long before the program ever runs. We will get no
such help in javascript....so beware. 

####Verifying Types

So javascript is dynamically checked, which provides us with a lot of flexibility, we often however would like to check the type
of something ourselves in the code. 

```javascript

var x  = 3; 

//we can use the typeof operator to determine type
console.log("x is of type: " + typeof x);

```

```javascript

var x = [];

//we can check an objects type with instanceof

console.log("x is of type: " + x.constructor ==  Array);
```
> Exercise: Write a type safe version of the function to calculate the minimum of two numbers

##ECMAScript

In the old days of the web...there were two javascripts...the Netscape Javascript(Brendan Eich created Javascript at Netscape), and Microsoft Javascript. This sucked, because having two versions of a language is bad, and so the need for a standard version emerged. ECMAScript is that standard version. 
It defines the core language features...things we would think about 

ECMAScript deals with specifying how the core language features should work...features like these:

* Syntax
* Objects
* Types
* Statements
* Keywords
* Reserved Words
* Operators

So ECMAScript deals with the core language features, outside of a host environment like the browser.  


##The host

Javascript is like a virus, both in the way it has infected every corner of the web development sphere, and in its
need for a host. 

Javascript needs a hosted environment in which to run, and it is that environment that determines the full extent of
functionality that is available to the programmer. 

Your web browser has an engine that runs the actual javascript code contained in your html pages. Without that engine
nothing would happen and your javascript code would never run. 

When the browser is hosting javascript, if it's Chrome, then the javascript code you write is executing on the V8 javascript engine. In the browser host enviorment..there are additional hooks, or 'API's' that we can make use of. These API's include things like the DOM and the BOM. It is through these API's that our javascript code is able to manipulate the web page and provide rich interactivity. 

With modern technologies we are also able to run javascript outside of the host environment of the browser, using it for server side processing. This is what 'nodejs' is. In this environment there are no API's to interact with the webpage's elements, as we are no longer in the browser environment. This is where we are likely to write ECMAscript, or plain old javscript 'the language.  


##The DOM

You will hear people refer to the **DOM** quite a bit. So it's really important to understand conceptually what it represents. The DOM is the Document Object Model. Essentially think of the DOM as an interface. It is an interface through which the javascript you write will interact with the elements on a web page. 

In the DOM model, you will think of, and interact with a page through the lens of **nodes**. Nodes are html elements, and importantly they can have child nodes. This hierarchy is what we refer to as the DOM tree. Take a look at the example below. 

```html
<!--The <div>(div is for divider) element has one child, 
a <p>(p is for paragraph) element-->
<div id="container">
   <p id="content">
     Hello World
   </p>
</div>
```
Javascript interacts with elements and their hierarchy through the DOM, where elements are modeled with nodes and their children. Nodes at the same level are called **siblings**.

Importantly, the DOM exposes 3 main areas of a page to Javascript. 

####Events

Things like a user clicking on a button, or the mouse cursor moving, or a user dragging their fingers across a page. These are piped to javascript as events.  Your code will listen for these events,and this is how your web pages will come alive. 

####Styling

Dynamically changing the way parts of a web page look is possible because the DOM also provides ways for us to manipulate the style properties of elements. You can write javascript code that will change the color of a button as a user mouses over it(you can also do this really easily with just CSS....but more on that later). 

####Traversal

So called __Walking the DOM__ is a very important capability, and the third major component of what the DOM offers us. Oftentimes it is necessary to process large chunks of a web page, or refer to an element relative to where it is in the node hierarchy. 

We do all of this using methods the DOM gives us to move from element to element on a page.

```bash
<div class="container">
    <p id="description">
        This thing is really nice.
    </p>
</div>

<script>
        /* The code below is an example of how we chain commands 
           together in javascript. The first part 'document' is our
           interface to the DOM, it is the object that has our entire
           node hierarchy. So we ask the DOM to return to us an element 
           that has an id 'description'. We then tell it to give us the 
           parent of that node, and from that parent node, we ask it 
           to give us whatever is between the element tags. 
           
           In essence what we have done is ask the the <p> tag above to
           provide a full spec of itself. Instead of assigning the output 
           of all of this to a variable, as we normally would, we stuff
           it inside an alert which is immediately displayed to us. 
        */
        alert( document.getElementById('description').parentNode.innerHTML )
</script>
```
###The BOM

Let's be clear...the BOM is the BOMB!!

Just as the DOM, document object model referred to the webpage itself, the BOM or Browser Object Model, refers to the browser itself. 

The BOM includes specifications for things that deal with the browser directly.

```javascript
 var win = window;
 
 win.location = "/anotherURL";
 
```

Take a peak now into your window object. 

For example, asking a user to share their location. This will pop up a confirmation box. Resizing the browser window, changing the window location..in other words navigating from page to page. Most importantly, this also specifies the XMLRequest Object, in other words...**the foundation of the modern web!!!**....much...much more on this later. 

##Let's talk script

The script tag is how we include javascript files on our webpages, and also how we write javascript directly onto our pages. Alternatively, you can write javascript inside of elements directly, but this is discouraged unless you have a really compelling reason for doing so. We'll look at both ways. 

```html

<!--Inline Javascript-->
<div id="inline-js" onclick='doSomething()'>Hello</div>

<!--We instead attach an event handler below-->
<div id="script-js">There</div>

<script>
   document.getElementById('script-js').addEventListener('click', function() {
      alert("Hey!")
   })

</script>

```

So where do we put script tags on a page? There are a couple of considerations here. To understand this a little more, we need to think a little bit about how the browser processes the page.  When a browser gets an html page, it starts fetching the assets declared in the <head> tag. 

If it finds javascript files, it will start executing them in the order it finds them, and won't start parsing any html until it's finished with the javascript. 

This means your page loads can be held up while the browser is executing javascript. It's better to either defer your scripts from executing, or place them at the bottom of the page, just outside your body page. 

```html
<head>
       <!--These scripts will load and execute in order-->
       <script src="jsFile.js" ></script>
       <script src="anotherJsFile.js" ></script>
</head>
<body>
       <!--This html will wait until all the js above
           has been completely executed before being 
           parsed and displayed to the user-->
       <div>Hey There</div>
</body>

```
A better way is either to defer, or load the scripts asynchronously. The most performant way is to load scripts asynchronously, but in this case you are not guaranteed the scripts execute in any particular order. This can be problematic if one script depends on something the other is supposed to do first.

Look closely below at the 'async' and 'defer' attributes added just inside the closing of the first part of each script tag. 

```html
<head>
      <!--Using defer is the same as putting scripts at the bottom
          of the page-->
       <script src="deferLoad.js" defer></script>
       <script src="deferLoad2.js" defer></script>
     
       <!--These scripts will load and execute at the same time the html is parsed
           The order of execution is not guaranteed-->
       <script src="asyncLoad.js" async></script>
       <script src="asyncLoad2.js" async></script>
</head>
<body>
       <!--The html now is parsed immediately as the 
           page is loaded-->
       <div>Hey There</div>
</body>

```

What will the following code do: 

```html 
<head>
    
    <script>var x = document.getElementById("blue")</script>
</head>
<body>
      <div id="blue">Blue </div>
</body>
```

##Proper Style

There are lot's of opinions on the best ways to write javascript, and nobody is totally write because at the end of the
day it's a question of style. There are however good guides to work off of so that you can start writing javascript
in a way that other programmers will respect, and demonstrate that you know what you're doing and it's not your first rodeo. 

Here is one such guide: [airbnb js style guide](https://github.com/airbnb/javascript/tree/master/es5)

##The Grammar
  

####Working with dates. Part of Javascript's core is a Date object that we can create and manipulate.

```javascript
//create a Date 
var today = new Date();


console.log( today.getFullYear() ); 
console.log( today.getMonth() ); 
console.log( today.getDate() ); 
console.log( today.getDay()  );
console.log( today.getHours() );
console.log( today.getUTCHours() ); 
console.log( today.toString() );

```

####Reserved words


**break**

```javascript
  function testBreak(x) {
   var i = 0;

   //keep looping up till i=5
   while (i < 6) {
      //check condition that i is equal to 3
      //NOTE: the double === is NOT strict equality
      //A type conversion will occur if i is NOT a 
      //number
      if (i == 3) {
         //exit the while loop if i == 3 it TRUE...
         //proceed with program execution...i.e. 
         // return i*x
         break;
      }
      i += 1;
   }
   return i * x;
}
```

**case**

```javascript
switch (expr) {
  case "Oranges":
    console.log("Oranges are $0.59 a pound.");
    break;
  case "Apples":
    console.log("Apples are $0.32 a pound.");
    break;
  case "Bananas":
    console.log("Bananas are $0.48 a pound.");
    break;
  case "Cherries":
    console.log("Cherries are $3.00 a pound.");
    break;
  case "Mangoes":
  case "Papayas":
    console.log("Mangoes and papayas are $2.79 a pound.");
    break;
  default:
    console.log("Sorry, we are out of " + expr + ".");
}


```
**catch**

```javascript
try {
   throw "myException"; // generates an exception
}
catch (e) {
   // statements to handle any exceptions
   logMyErrors(e); // pass exception object to error handler
}
```

**class**

```javascript
// ECMASCRIPT 6 standard
```
**const**

```javascript
// define my_fav as a constant and give it the value 7
const my_fav = 7;

// this will fail silently in Firefox and Chrome (but does not fail in Safari)
my_fav = 20;

// will print 7
console.log("my favorite number is: " + my_fav);

// trying to redeclare a constant throws an error 
const my_fav = 20;

// the name my_fav is reserved for constant above, so this will also fail
var my_fav = 20; 
```
**continue**
```javascript
i = 0;
n = 0;
while (i < 5) {
   i++;
   if (i === 3) {
      continue;
   }
   n += i;
}
```
**debugger**
```javascript
function potentiallyBuggyCode() {
    debugger;
    // do potentially buggy stuff to examine, step through, etc.
}
```

**delete**
```javascript
x = 42;         // creates the property x on the global object
var y = 43;     // declares a new variable, y
myobj = {
  h: 4,
  k: 5
};

// x is a property of the global object and can be deleted
delete x;       // returns true

// delete doesn't affect variable names                
delete y;       // returns false 

// delete doesn't affect certain predefined properties
delete Math.PI; // returns false 

// user-defined properties can be deleted
delete myobj.h; // returns true 

// myobj is a property of the global object, not a variable,
// so it can be deleted
delete myobj;   // returns true
```

**else**
```javascript
if (x > 5) {

} else if (x > 50) {

} else {

}
```
**export**
```javascript
//allows you to not use script tags to include js in other files.
```
**extends**
```javascript
//ECMAScript 6 inheritance in JS from another class
```
**finally**
```javascript
openMyFile()
try {
   // tie up a resource
   writeMyFile(theData);
}
finally {
   closeMyFile(); // always close the resource
}
```
**for**
```javascript
for (var i = 0; i < 9; i++) {
   console.log(i);
   // more statements
}
```
**function**
```javascript
//HOISTED
hoisted(); // logs "foo"

function hoisted() {
  console.log("foo");
}

//NOT HOISTED
notHoisted(); // TypeError: notHoisted is not a function

var notHoisted = function() {
   console.log("bar");
};
```
**if** 
```javascript
x = 3;
y = '3';

if (x ==== y) {
   //does the following line execute?
   doSomething();
   
}
```
**in** 
```javascript
var obj = {a:1, b:2, c:3};
    
for (var prop in obj) {
  console.log("o." + prop + " = " + obj[prop]);
}

// Output:
// "o.a = 1"
// "o.b = 2"
// "o.c = 3"
```
**instanceof**
```javascript
var simpleStr = "This is a simple string"; 
var myString  = new String();
var newStr    = new String("String created with constructor");
var myDate    = new Date();
var myObj     = {};

simpleStr instanceof String; // returns false, checks the prototype chain, finds undefined
myString  instanceof String; // returns true
newStr    instanceof String; // returns true
myString  instanceof Object; // returns true

myObj instanceof Object;    // returns true, despite an undefined prototype
({})  instanceof Object;    // returns true, same case as above

myString instanceof Date;   // returns false

myDate instanceof Date;     // returns true
myDate instanceof Object;   // returns true
myDate instanceof String;   // returns false
```
**let**
```javascript
//The let keyword is only available to code blocks in HTML wrapped in a
//<script type="application/javascript;version=1.7">

//Let provides block scoping, whereas var is function scoped
//gamma is constrained to the curly braces, outside of which
//it will be undefined
if (x > y) {
  let gamma = 12.7 + y;
  i = gamma * x;
}
```
**new** 
```javascript
function car(make, model, year) {
   this.make = make;
   this.model = model;
   this.year = year;
}

var mycar = new car("Eagle", "Talon TSi", 1993);
```

**return**
```javascript
//Return is affected by automatic semi-colon insertion
return
a + b;

// is transformed by ASI into
return; 
a + b;
```
**super**
```javascript
//Used in ES6 classes
```
**switch**
```javascript
//Since we already saw some basic switches...lets look at multi-criteria
var foo = 1;
switch (foo) {
    case 0:
    case 1:
    case 2:
    case 3:
        alert('yes');
        break;
    default:
        alert('not');
}

//Another way
var foo = 1;
switch (true) { // invariant TRUE instead of variable foo
    case foo >= 0 && foo <= 3:
        alert('yes');
        break;
    default:
        alert('not');
}
```
**this**
```javascript
//--------GLOBAL CONTEXT------------
console.log(this.document === document); // true

// In web browsers, the window object is also the global object:
console.log(this === window); // true

this.a = 37;
console.log(window.a); // 37

//--------FUNCTION CONTEXT-------------------
function f1(){
  return this;
}

f1() === window; // global object

//----------AS AN OBJECT METHOD--------------

/**/
var o = {
  prop: 37,
  f: function() {
    return this.prop;
  }
};

console.log(o.f()); // logs 37

var o = {prop: 37};

/**/
function independent() {
  return this.prop;
}

o.f = independent;

console.log(o.f()); // logs 37

//---------THIS ON PROTOTYPE CHAIN---
var o = {f:function(){ return this.a + this.b; }};
var p = Object.create(o);
p.a = 1;
p.b = 4;

console.log(p.f()); // 5

//---------------THIS WITH A GETTER OR SETTER-----
function modulus(){
  return Math.sqrt(this.re * this.re + this.im * this.im);
}

var o = {
  re: 1,
  im: -1,
  get phase(){
    return Math.atan2(this.im, this.re);
  }
};

Object.defineProperty(o, 'modulus', {
    get: modulus, enumerable:true, configurable:true});

console.log(o.phase, o.modulus); // logs -0.78 1.4142

//-----------------AS A CONSTRUCTOR---------------------
/*
 * Constructors work like this:
 *
 * function MyConstructor(){
 *   // Actual function body code goes here.  
 *   // Create properties on |this| as
 *   // desired by assigning to them.  E.g.,
 *   this.fum = "nom";
 *   // et cetera...
 *
 *   // If the function has a return statement that
 *   // returns an object, that object will be the
 *   // result of the |new| expression.  Otherwise,
 *   // the result of the expression is the object
 *   // currently bound to |this|
 *   // (i.e., the common case most usually seen).
 * }
 */

function C(){
  this.a = 37;
}

var o = new C();
console.log(o.a); // logs 37


function C2(){
  this.a = 37;
  return {a:38};
}

o = new C2();
console.log(o.a); // logs 38

//----------WITH CALL AND APPLY----------------
function add(c, d){
  return this.a + this.b + c + d;
}

var o = {a:1, b:3};

// The first parameter is the object to use as
// 'this', subsequent parameters are passed as 
// arguments in the function call
add.call(o, 5, 7); // 1 + 3 + 5 + 7 = 16

// The first parameter is the object to use as
// 'this', the second is an array whose
// members are used as the arguments in the function call
add.apply(o, [10, 20]); // 1 + 3 + 10 + 20 = 34

//---------AS DOM EVENT HANDLER------------------------
// When called as a listener, turns the related element blue
function bluify(e){
  // Always true
  console.log(this === e.currentTarget); 
  // true when currentTarget and target are the same object
  console.log(this === e.target);
  this.style.backgroundColor = '#A5D9F3';
}

// Get a list of every element in the document
var elements = document.getElementsByTagName('*');

// Add bluify as a click listener so when the
// element is clicked on, it turns blue
for(var i=0 ; i<elements.length ; i++){
  elements[i].addEventListener('click', bluify, false);
}
/*As inline event handler*/
<button onclick="alert(this.tagName.toLowerCase());">
  Show this
</button>


```
**throw** 
```javascript
function UserException(message) {
   this.message = message;
   this.name = "UserException";
}
function getMonthName(mo) {
   mo = mo-1; // Adjust month number for array index (1=Jan, 12=Dec)
   var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
      "Aug", "Sep", "Oct", "Nov", "Dec"];
   if (months[mo] !== undefined) {
      return months[mo];
   } else {
      throw new UserException("InvalidMonthNo");
   }
}

try {
   // statements to try
   var myMonth = 15; // 15 is out of bound to raise the exception
   monthName = getMonthName(myMonth);
} catch (e) {
   monthName = "unknown";
   logMyErrors(e.message, e.name); // pass exception object to err handler
}
```
**try** 
```javascript
try {
   throw "myException"; // generates an exception
}
catch (e) {
   // statements to handle any exceptions
   logMyErrors(e); // pass exception object to error handler
}
```
**typeof**
```javascript
// Numbers
typeof 37 === 'number';
typeof 3.14 === 'number';
typeof Math.LN2 === 'number';
typeof Infinity === 'number';
typeof NaN === 'number'; // Despite being "Not-A-Number"

/*Below is what is known as a Typed Wrapper. This produces an
object that has a valueOf method that returns the wrapped value. 
This turns out to be completely unnecessary and occasionally confusing.*/
typeof Number(1) === 'number'; // but never use this form!


// Strings
typeof "" === 'string';
typeof "bla" === 'string';
typeof (typeof 1) === 'string'; // typeof always return a string
typeof String("abc") === 'string'; // but never use this form!


// Booleans
typeof true === 'boolean';
typeof false === 'boolean';
typeof Boolean(true) === 'boolean'; // but never use this form!


// Symbols
typeof Symbol() === 'symbol'
typeof Symbol('foo') === 'symbol'
typeof Symbol.iterator === 'symbol'


// Undefined
typeof undefined === 'undefined';
typeof blabla === 'undefined'; // an undefined variable


// Objects
typeof {a:1} === 'object';

// use Array.isArray or Object.prototype.toString.call
// to differentiate regular objects from arrays
typeof [1, 2, 4] === 'object';

typeof new Date() === 'object';


// The following is confusing. Don't use!
typeof new Boolean(true) === 'object'; 
typeof new Number(1) === 'object'; 
typeof new String("abc") === 'object';


// Functions
typeof function(){} === 'function';
typeof Math.sin === 'function';
```
**var** 
```javascript
//Initializing two variables
var a = 0, b = 0;

//-------------------------
//Accidental global scope
var x = 0;

function f(){
  var x = y = 1; // x is declared locally. y is not!
}
f();

console.log(x, y); // 0, 1
// x is the global one as expected
// y leaked outside of the function, though! 

// This stands since the beginning of JavaScript
typeof null === 'object';
```
**void** 
```javascript
//Don't use void, forget seeing it. 

```
**while**
```javascript
var n = 0;
var x = 0;

while (n < 3) {
  n++;
  x += n;
}

```
**with**
```javascript
/*Don't use with, forget you saw it*/
```
**yield**
```javascript
//FUTURE ECMA6 keyword

```

Exercises



1. Write a program in javascript that takes one menu item as an argument.

> If a vegan can eat it, return "This cuisine is vegan friendly."

> Otherwise, return "Vegans beware!"

2. Write a program that creates two dates. 

> Test that the first date is less than the second, if it is print the first date out to the console. 
  Test that the dates have the same year, also test that they have the same day. 
  
3. Write a function that prints the square of a number.   
 
4. Challenge: Write a program that will prompt a user for input. If the user enters only integers, add one to the number they entered and display it back to them. 
 If they enter characters....check the type of their input and print it back to them.  
