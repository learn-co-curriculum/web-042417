---
title: Functions and Scope
type: lesson
duration: "1hr 45min"
creator:
  name: Tony
  city: NYC
competencies: JS Functions
---

# JavaScript Functions 
We know you've already looked at functions while you were working through your pre-work, but we're gonna review everything you covered, and then some! Welcome to the world of JavaScript functions! [*Queue corny School House Rock song!*](https://youtu.be/ODGA7ssL-6g)
<br>

### Objectives
*After this lesson, students will be able to:*

- Function declaration vs function expression vs arrow functions
- Execution Context (Creation & Execution)
- Lexical Environment & Scope Chain
- Closures
- First Class Citizens
- Functions as arguments (Callback Functions)
- Pure Functions
 
**BONUS**

- IIFE
- Constructor Functions


### Review Questions
**Q:** Why are functions important to use? 

**Q:** What's the difference between a *parameter* and an *argument*? 

<br>
<br>
<br>
<br>

**A:** Functions are reusable, and keep your code DRY & organized; more answers etc...

**A:** When a function that needs information is declared, the items inside of the parantheses (immediatley after the function name) are paramenters, as are those same items inside of the curlies. The parameters are used like variables within your function. When you *call* a function that needs information, the informtion you pass into the function (or parens) are *arguments*.

## Creating functions

**Functions Expression:**

```javascript
var funcExpression = function a(){
	console.log("function a")
	a()//you wouldn't really do this just proving a point
}

//anonymous function
var funcExpAnonymous = function(){
	console.log("I have no name")
}
```
>Invoke a function or function invocation refers to what?

**Functions Declaration:**

```javascript
function declaration(){
	console.log("I'm special")
}
```

>What is the main difference between the two definitions of the functions above?


**ES6 Arrow Function Expressions:**

_An arrow function expression has a shorter syntax than a function expression and does not bind its own this, arguments, super, or new.target. These function expressions are best suited for non-method functions, and they cannot be used as constructors._



```javascript
var arrow = () => console.log("Don't I look cool?")

var noParens = arg => console.log(arg)

var multiple = (arg1,arg2) => {
	if(arg1 > arg2) return true
	return false
}
```

>For what purpose would I use an arrow function over the previous two definitions?


## Execution Context
The Execution Context is the abstract concept of the environment in which the current code is being evaluated in.
In the ES5 documentation, the execution context “contains whatever state is necessary to track the execution progress of its associated code”.
Typically, this “environment” is either: (1) the default global environment or (2) the function environment, code inside a function.

### Phase 1: Creation
When the JavaScript interpreter “compiles” the code line-by-line before it is executed, it creates a call stack. Because JavaScript is a single threaded language, only one thing can happen in the browser at a time, the rest are in this call stack waiting to be run.

During the microseconds before JavaScript code is ever executed, three things happen during the creation phase:

1. The `this` pointer determined.
2. The Lexical Environment is defined (outer).
3. The Variable Environment is defined (global object).

![](https://c870c6b4d604.gitbooks.io/ecmascript6/content/variables/global_execution_context_3.png)

_**Aside**_ - This is how hoisting works!

Every invokation of a function creates its own execution context that is added to the stack, with the above 3 items defined all over again. It depends on where it sits physically in the code. 

### Phase 2: Execution

After the V8 Engine has gone through the code, bound the this keyword and defined the LexicalEnvironment and the VariableEnvironment, finally the code is executed!
Here, assignments to those variable/function declarations are finally done (i.e., those “hoisted” variables are now properly defined!), code is run and we see the end result of our code!

**Example:**

```javascript
function b() {
	console.log(num*2)
}

function a( ) {
	var num = 2
	b()
}

a()

var num = 1
```

![](http://www.supermart.ng/blog/assets/images/ab-exec-cont.png)

>What value will be printed to the console?

<br>
<br>
<br>
When the console.log function within function b runs, it looks for the variable num within function b’s execution context. As we can see in the diagram above, there’s nothing in the memory space of its execution context. Since num cannot be found in this execution context, the JavaScript engine looks through the scope chain to find a reference to the outer environment.

Function b’s outer environment, surprisingly (at least to me at the time), happens to be the global environment and not function from whence it was called. Why? Because function b sits lexically in the global environment.



## Lexical Environment and Scope
Often you will hear people refer to Javascript as being lexically scoped....what are they talking about? Lexical scope sounds fancy.....is it?
Not really, its a really simple statement when you break it down. 

 > *a simple definition*: 
 > **Lexical** - relating to words or vocabulary
 
_**Lexically**_ in this context means where code is defined i.e. where it sits physically. 

The official ES5 docs defines Lexical Environment (an abstract concept really) as the place where “the association of Identifiers to specific variables and functions based upon the lexical nesting structure of ECMAScript code” is stored. Jargon aside, there are two main takeaways from this definition:

**Identifier** associations are simply the binding between variable and function declarations with their values. (e.g., let x = 10, 'x' is bound to '10').

**Lexical** structure is just describing the actual location where the code was written.

#### TONY ANALOGY ALERT:

If you consider an interrogation room with a two way mirror, you can see that when the interrogation room is bright, and the 
 'observation room' is dark, then like in the movies you can picture detectives watching an interrogation while those in the interrogation
 room cannot see through the mirror into the observation room. 
 
 Scope works like this in javascript, where you can imagine the inner most function as the detectives sitting in the observation room, unseen
 by the outer function in the interrogation room. 
 
 
 ```javascript
 function outer () {
 
     var visibleToInner  = 1; 
     
     function inner() {
        console.log(visibleToInner);        
        var hiddenFromOuter = 2;    
     }
    //executing inner we can see visibleToInner is defined inside
    //the inner function
    inner();  
   
    console.log(hiddenFromOuter); //hiddenFromOuter will be undefined  
 }
 
 ```
 
 Show me your thumbs on how well you understood everything so far. 
 <br>
 <br>
 👍 I get it! 
 👎 I'm not sure. 
 👊 Maybe with some more examples. 
 
 

 
 ## Closure
 
 A closure is an inner function that has access to the outer (enclosing) function’s variables—scope chain. The closure has three scope chains: it has access to its own scope (variables defined between its curly brackets), it has access to the outer function’s variables, and it has access to the global variables.


```javascript
function someFunction() {
  var i = 3
  return function innerFunction() {
    return i
  }
}
 
var sf = somefunction();
sf(); //=> 3
```

![](https://qph.ec.quoracdn.net/main-qimg-ae08e3ce1e5fca8a58c5fb7d7f711038)


>Once the function is finished running it is popped off the stack then we create a new execution context. That has access to all the outer variables. 

![](https://qph.ec.quoracdn.net/main-qimg-becfd85fdef112f54a3e35b30a13afbe)


Remember its not something you create or you tell javascript to do. It is a feature of the language and it happens naturally so we must know that it exists. JS will always ensure the function running always has access to the variables it is suppose to have access to!

## First Class Citizens

In programming languages, when you are able to pass, return and assign a type, that type is considered to be a first class citizen. This is one reason Javascript is becoming a popular destination for functional programming. Since we are able to create functions that can accept functions as well as return functions. This allows us to create Higher Order Functions. Higher Order Functions are functions that accept a function, and/or return a function.

>Basically, first-class citizenship simply means “being able to do what everyone else can do.”


```javascript

//We can pass functions as arguments!
var names = ['Tony','Johann','Jason']

names.forEach(function(e,i){
	
	console.log(`index: ${i}, value: ${e}`)
	
})
```

### Callbacks


We can pass functions around like variables and return them in functions and use them in other functions. When we pass a callback function as an argument to another function, we are only passing the function definition. We are not executing the function in the parameter. In other words, we aren’t passing the function with the trailing pair of executing parenthesis () like we do when we are executing a function.

And since the containing function has the callback function in its parameter as a function definition, it can execute the callback anytime.

When we pass a callback function as an argument to another function, the callback is executed at some point inside the containing function’s body just as if the callback were defined in the containing function. This means the callback is a closure.

**Use Named OR Anonymous Functions as Callbacks**

```javascript
// define our function with the callback argument
function some_function(arg1, arg2, callback) {
  // this generates a random number between
  // arg1 and arg2
  var my_number = Math.ceil(Math.random() * (arg1 - arg2) + arg2)
  // then we're done, so we'll call the callback and
  // pass our result
  callback(my_number)
}
// call the function
some_function(5, 15, function(num) {
  // this anonymous function will run when the
  // callback is called
  console.log("callback called! " + num)
})
```

## Pure Functions

A pure function doesn’t depend on and doesn’t modify the states of variables out of its scope.

Concretely, that means a pure function always returns the same result given same parameters. Its execution doesn’t depend on the state of the system.

Pure functions are a pillar of functional programming.


```javascript
var values = { a: 1 };

function impureFunction ( items ) {
  var b = 1;

  items.a = items.a * b + 2;

  return items.a;
}

var c = impureFunction( values );

```

>Is this a pure function?


```javascript
var values = { a: 1 };

function pureFunction ( a ) {
  var b = 1;

  a = a * b + 2;

  return a;
}

var c = pureFunction( values.a );
// `values.a` has not been modified, it's still 1
```

Notice we did not mutate the object but used the value to return a new value seperate from the object. 

Another example:

```javascript
// impure addToCart mutates existing cart
const addToCart = (cart, item, quantity) => {
  cart.items.push({
    item,
    quantity
  });
  return cart;
};


// Pure addToCart() returns a new cart
// It does not mutate the original.
const addToCart = (cart, item, quantity) => {
  const newCart = Object.assign({}, cart)

  newCart.items.push({
    item,
    quantity
  })
  return newCart

}
```

>The Object.assign() method is used to copy the values of all enumerable own properties from one or more source objects to a target object. It will return the target object.
 	

```javascript
var obj = { a: 1 };
var copy = Object.assign({}, obj);
console.log(copy); // { a: 1 }
```


# Bonus

### Immediately-Invoked Function Expression (IIFE)



```javascript

(function(){
	console.log("I get executed right away!")
})()

function(){}()
```

Here are some brain twisters:

```javascript
 
function foo() { foo(); }
// This is a self-executing anonymous function. Because it has no
// identifier, it must use the  the `arguments.callee` property (which
// specifies the currently executing function) to execute itself.
var foo = function() { arguments.callee(); };
// This *might* be a self-executing anonymous function, but only while the
// `foo` identifier actually references it. If you were to change `foo` to
// something else, you'd have a "used-to-self-execute" anonymous function.
var foo = function() { foo(); };
// Some people call this a "self-executing anonymous function" even though
// it's not self-executing, because it doesn't invoke itself. It is
// immediately invoked, however.
(function(){ /* code */ }());
// Adding an identifier to a function expression (thus creating a named
// function expression) can be extremely helpful when debugging. Once named,
// however, the function is no longer anonymous.
(function foo(){ /* code */ }());
// IIFEs can also be self-executing, although this is, perhaps, not the most
// useful pattern.
(function(){ arguments.callee(); }());
(function foo(){ foo(); }());
// One last thing to note: this will cause an error in BlackBerry 5, because
// inside a named function expression, that name is undefined. Awesome, huh?
(function foo(){ foo(); }());
```

### Constructor Functions

Constructors are like regular functions, but we use them with the "new" keyword. There are two types of constructors: native (aka built-in) constructors like Array and Object, which are available automatically in the execution environment at runtime; and custom constructors, which define properties and methods for your own type of object.

A constructor is useful when you want to create multiple similar objects with the same properties and methods. It’s a convention to capitalize the name of constructors to distinguish them from regular functions. Consider the following code:

```javascript
function Book(){
}

var myBook = new Book()
```

The last line of the code creates an instance of Book and assigns it to a variable; even though the Book constructor doesn't do anything, myBook is still an instance of it. As you can see there is no difference between this function and regular functions except that we call it with the new keyword and the function name is capitalized.

```javascript
myBook instanceof Book    // true
myBook instanceof String  // false
myBook.constructor == Book;   // true
```


