# JavaScript Prototypes & Classes
- - - 

## Learning Objectives
Students will be able to:

- Use Prototypes to save memory
- Use Prototypes to implement inheritance (prototypal inheritance)
- Use Prototypes to share data between all instances of a constructor
- Use Prototypes to add functionality to built-in object types
- Use Prototypes to change a method's behavior (polymorphism)

## Roadmap

1. Why learn about JS Prototypes?
2. Understanding the _Prototype Chain_.
3. Using Prototypes to save memory.
4. Create our own object model using prototypal inheritance.
5. Share data between all instances of a type.
6. Add functionality to built-in object types.
7. Change the behavior of an inherited method.
8. JS Classes syntax
9. Extends
10. Super


## 1. Why learn about JS Prototypes?

### Object Oriented Programming

In traditional class-oriented languages, you create classes, which are templates for objects. When you want a new object, you instantiate the class, which tells the language engine to copy the methods and properties of the class into a new entity, called an instance. The instance is your object, and, after instantiation, has absolutely no active relation with the parent class.

As web developers, we typically use OOP techniques.

With OOP, our programs are crafted from objects that usually model real world objects that interact with each other.

Often, these objects have small amounts of common functionality.
e.g., a User object and a Student object would both have _name_ and _email_ properties, etc.

Coding this common functionality over and over in similar objects would be wasteful and inefficient.

This inefficiency is addressed in OOP with a fundamental principle known as _inheritance_.

Inheritance allows objects to "inherit" properties from other objects as a starting point, then they can customize them as necessary. Remember, _properties_ include methods.

**ASK: Think of some everyday objects that inherit some properties from other objects, e.g. vehicles**

Just like in nested HTML, objects can have _parent/child_ and _ancestor/descendent_ relationships between them.

We often graph these relationships, or _object models_, which can look something like this:

```
      Employee
         |
        / \
 Manager   Worker Bee
             \
            Engineer

```

To help us discover potential relationships between objects, it helps to ask if an "is-a" relationship exists.  For example, "a manager _is-a_ employee".

JavaScript’s flavor of inheritance is known as _Prototypal Inheritance_ that is implemented by using an object known as a Prototype.  When we create new objects using a constructor function, the new object "inherits" the properties that exist in the constructor's prototype object. Yes, the prototype is just an regular JavaScript object.

This differs from "classical" inheritance where _classes_ serve as the blueprints from which new objects are created.

__Knowledge regarding the use of JavaScript’s prototype is important if we are to follow OOP principles when crafting a complex web application.__

## 2. Understanding the Prototype Chain

Lets create a new object in the console:

```
> var myObj = { prop1: "value1" };
```
Now lets type _myObj_ followed with a dot.  Look at all of those properties that myObj has in addition to the _prop1_ property that we created.

You are witnessing inheritance and something called the _prototype chain_ in action!

Every object has a secret link to the _prototype_ object of its parent object (usually a constructor) - and the properties on that prototype object are made available to the child object.

Lets look closer at _myObj_ in the console:

```
// Remember, using object literal notation to create new objects is just
// a shortcut for calling "var myObj = new Object();".  So myObj was actually
// created by the Object() constructor function!
> myObj.constructor
< function Object() { [native code] }
// or
> myObj.constructor.name
< "Object"
```
So, we now know that the parent of _myObj_ is the Object() constructor.  Not lets take a look at the _prototype_ property of _Object_ in the console by typing _Object.prototype_ and pressing dot.

```
> myObj.constructor.
```

There they are!  _myObj_ inherited those properties from its constructor's, Object(), prototype object!

_Object.prototype_ is special because all objects ultimately derive from it, unless an object is created like this.

Think of the Object.prototype as always being at the top of our program's object model.

Next, lets create a string in the console:

```
var s = "hello";
```

**What is its constructor?**

**What are some properties that our string inherited from String.prototype?**

**Are the properties from Object.prototype still available?**

Yes, courtesy of the _prototype chain_.

Lets explore further by typing the following in the console:

```
> console.dir(String);
```
That ____proto____ object inside of String's prototype is the secret link referred to earlier.  Follow it to traverse the _prototype chain_.

**Explain how the _prototype chain_ is traversed when properties are accessed using a diagram**

<img src="https://qph.ec.quoracdn.net/main-qimg-783aa5dc1ed38afb506338d187ed24b2" width="500">

Note: If the Object.prototype is reached, and it does not contain the property being accessed, _undefined_ is returned.

**Put in parking lot to demo _hasOwnProperty_ method**

## 3. Using Prototypes to save memory

**INVOLVE class in building out this BankAccount constructor**

```javascript
function BankAccount(ownerName, begBalance) {
    var accountNumber = (new Date()).getTime();
    
    this.ownerName = ownerName;
    this.balance = begBalance;
    
    this.getAccountNumber = function() { return accountNumber;};
    this.deposit = function(amount) { this.balance += amount; return this.balance; };
    this.withdrawal = function(amount) { this.balance -= amount; return this.balance; };
}
```
**ASK: A banking application might create thousands of these BankAccount's.  Can anyone tell me what is repeated in each instance, but doesn't have to be?**

Instead, we can attach our methods to the prototype of the object's constructor:

```javascript
function BankAccount(ownerName, begBalance) {
    var accountNumber = (new Date()).getTime() + '';
    
    this.ownerName = ownerName;
    this.balance = begBalance;
    
    this.getAccountNumber = function() { return accountNumber; };
}

BankAccount.prototype.deposit = function(amount) { this.balance += amount; return this.balance; };
BankAccount.prototype.withdrawal = function(amount) { this.balance -= amount; return this.balance; };
```

There is only a single copy of the constructor function in memory, so by moving our object's methods to the prototype of the constructor, there will be only one copy of those functions, instead of thousands!


## 4. Create our own object model using prototypal inheritance

We're going to use prototypal inheritance to specialize, or _extend_, our BankAccount object.  In OOP, this is often referred to as sub-classing.

Lets first create a _CheckingAccount_ constructor that includes the same properties as it's parent (_BankAccount_), plus any new parameters we want to add, in this case, an _overdraftEnabled_ parameter:

```javascript
function CheckingAccount(ownerName, begBalance, overdraftEnabled) {
}
```
Next, we want to attach the properties of the parent type, however, we will not simply assign them to _this_.  Instead, we will use the parent's constructor to set them for us like this:

```javascript
function CheckingAccount(ownerName, begBalance, overdraftEnabled) {
    BankAccount.call(this, ownerName, begBalance);
}
```
Here we are using the _call_ method that is available to all functions that allows us to change the context of _this_ inside the function.

**DISCUSS this process and review that inside a constructor function - _this_ represents a new empty object**

Now lets add our new data to our new object:

```javascript
function CheckingAccount(ownerName, begBalance, overdraftEnabled) {
    BankAccount.call(this, ownerName, begBalance);
    this.overdraftEnabled = overdraftEnabled || true;
}
```
**DEMO creating a new CheckingAccount and verify parent type's functionality<br>
- Notice that all the functionality, including the getAccountNumber method has been provided.<br>- However, the _deposit_ and _withdrawal_ methods in BankAccount prototype is NOT available**

In order to properly set the prototype of our new constructor, we write this code after our constructor function definition:

```javascript
// CheckingAccount constructor function defined above...

CheckingAccount.prototype = Object.create(BankAccount.prototype);
```
**DEMO that _deposit_ and _withdrawal_ methods now exist and work**

Sometimes you may see an actual full instance of the parent constructor being used to set the prototype, however, using Object.create() does not duplicate instance properties on the prototype.

**EXPLORE an instance of CheckingAccount using _console.dir_.<br> Note that a constructor property on CheckingAccount's prototype does not exist (like it does on BankAccount) because we need to set it after setting the prototype:**

```javascript
// CheckingAccount constructor function defined above...

CheckingAccount.prototype = Object.create(BankAccount.prototype);
CheckingAccount.prototype.constructor = CheckingAccount;
```

Now it's there!

Next, let's add functionality to CheckingAccount by attaching a method to its prototype that we just setup.

```javascript
// CheckingAccount constructor function defined above...
CheckingAccount.prototype = Object.create(BankAccount.prototype);
CheckingAccount.prototype.constructor = CheckingAccount;

CheckingAccount.prototype.orderChecks = function() { return 'Checks have been ordered for Account: ' + this.getAccountNumber(); };
```

**DEMO _orderChecks_ method**

**DEMO _instanceof_ to show that the variable is an instance of both BankAccount and CheckingAccount.

### Review: Steps to implement Prototypal Inheritance

1. Create a new constructor function that includes the same parameter list as the parent constructor.
2. Add additional parameters as needed.
3. Inside of the new constructor, use the parent's constructor to add the instance properties to the new empty object (_this_) by calling the parent's constructor function (_super constructor_) using _call_ and passing in _this_ along with the required arguments.
4. Use the new parameters, etc. to specialize the object by creating properties on _this_.
5. Set the new constructor's prototype to an instance of the parent's constructor.prototype like this:  Object.create(_parentConstructor_.prototype).
6. Create a _constructor_ property on the _prototype_ object and set it to a reference to the new constructor function.  This "circular" reference is a pattern the JavaScript engine follows.
7. Customize the new constructor's prototype by adding methods and/or _shared_ data to it.


## 5. Share data between all instances of a type

Just like we share the same copy of a function between all instances of a constructor, we can share data in the same way.

For example, we can add a _bankName_ property to the BankAccount.prototype like this:

```javascript
BankAccount.prototype.bankName = "Bank of WDI";
```

Now, any instance of BankAccount or its sub-classes, will share the _bankName_ property.

If its value is changed, all existing and future instances will see the new value.

## 6. Add functionality to built-in object types

Thanks to the dynamic nature of JavaScript objects, its quite easy to add additional functionality to existing types.

For example, the following code will add a new method called _zerofy_ to Number's prototype.

```javascript
Number.prototype.zerofy = function(size) {
    var s = this.toString();
    while (s.length < size) {
      s = '0' + s;
    }
    return s;
};
```

**DEMO zerofy method**

## 7. Change the behavior of an inherited method

We can change the behavior of an inherited method by simply writing a method with the same name somewhere down the prototype chain.  This "overriding" of behavior is known as a form of _polymorphism_, another principle of OOP.

As an example, lets change the behavior of the _withdrawal_ method on _CheckingAccount_ which it inherited from _BankAccount_:

```javascript
CheckingAccount.prototype.withdrawal = function(amount) {
    if ( this.overdraftEnabled || amount <= this.balance ) {
        this.balance -= amount;
        return this.balance;
    } else {
        return "NSF";
    }
};
```
**DEMO new _withdrawal_ method**

## The ES6 Way

It's important to note that there are no classes in JavaScript. Functions can be used to somewhat simulate classes, but in general JavaScript is a class-less language. Everything is an object. And when it comes to inheritance, objects inherit from objects, not classes from classes as in the "class"-ical languages.

### 8. Creating a JS class

```javascript

// Food is a base class
class Food {

    constructor (name, protein, carbs, fat) {
        this.name = name;
        this.protein = protein;
        this.carbs = carbs;
        this.fat = fat;
    }

    toString () {
        return `${this.name} | ${this.protein}g P :: ${this.carbs}g C :: ${this.fat}g F`
    }

    print () {
      console.log( this.toString() );
    }
}

const chicken_breast = new Food('Chicken Breast', 26, 0, 3.5);

chicken_breast.print(); // 'Chicken Breast | 26g P :: 0g C :: 3.5g F'
console.log(chicken_breast.protein); 
```

>Classes can only contain method definitions, not data properties;
When defining methods, you use shorthand method definitions;
Unlike when creating objects, you do not separate method definitions in class bodies with commas; and
You can refer to properties on instances of the class directly

**Create classes as constants**
``` const Food = class { //code } ```

### 9. Extends with classes

```javascript

// FatFreeFood is a derived class
class FatFreeFood extends Food {

    constructor (name, protein, carbs) {
        super(name, protein, carbs, 0);
    }

    print () {
        super.print(); 
        console.log(`Would you look at that -- ${this.name} has no fat!`);
    }

}

const fat_free_yogurt = new FatFreeFood('Greek Yogurt', 16, 12);
fat_free_yogurt.print(); // 'Greek Yogurt | 26g P :: 16g C :: 0g F  /  Would you look at that -- Greek Yogurt has no fat!'
```

>Subclasses are declared with the class keyword, followed by an identifier, and then the extends keyword, followed by an arbitrary expression. This will generally just be an identifier, but could, in theory, be a function.
If your derived class needs to refer to the class it extends, it can do so with the super keyword.
A derived class can't contain an empty constructor. Even if all the constructor does is call super(), you'll still have to do so explicitly. It can, however, contain no constructor.
You must call super in the constructor of a derived class before you use this.

#### How super works in JS

1. Within subclass constructor calls. If initializing your derived class requires you to use the parent class's constructor, you can call ```super(parentConstructorParams[ )``` within the subclass constructor, passing along any necessary parameters.

2. To refer to methods in the superclass. Within normal method definitions, derived classes can refer to methods on the parent class with dot notation: ```super.methodName```.



## Essential Questions
1. List at least two purposes of JS prototypes.
2. Describe how properties are accessed through the prototype chain.

## References

[Wikipedia - Object Oriented Programming](http://en.wikipedia.org/wiki/Object-oriented_programming)

[BankAccount & CheckingAccount code](https://gist.github.com/jim-clark/e3fc426d73153fac6dc1)
