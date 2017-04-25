---
title: Ruby Basics
type: lesson
duration: "1:25"
creator:
    name: Tony Guerrero
    city: NYC
competencies: Programming
---

# Intro to Ruby - Data Types & Variables

### Objectives
*After this lesson, students will be able to:*

- Identify and describe use cases for Ruby's data types
- Describe the different types of variables (locals, instance, constants) in Ruby & when to use them
- Run a Ruby file in the command line


## Intro (10 mins)

Now that we've got your feet wet with HTML, you've got a taste of what it's like to start building for the web – and we're about to kick it up a notch.

Originally, the web was meant just as a place for documents – HTML pages that linked to each other, that was it.

But as developers started creating more and more pages, and desiring more and more interactivity with those pages, we got to a point historically where we started writing that created HTML for us. That was where the concept of web development frameworks came from, and undoubtedly one of the most prolific has been Ruby on Rails – one of the first frameworks to use the language of Ruby to build web applications.

We're not going to jump right into Rails immediately, we're going to build up to it over the course of the next week, and make sure you have an understanding of the concepts that go into building it first.

But even before _that_, let's get our hands dirty with some straight **Ruby**. It's super readable and easy to get started with, you're gonna like it a lot.

### "Matz is Nice And So We Are Nice"
Ruby was created by Yukihiro Matsumoto a.k.a. "Matz" in the mid-1990s. It is an object-oriented scripting language built on-top of C which Matz created to help programmers enjoy coding! 

> <cite>"I hope to see Ruby help every programmer in the world to be productive, and to enjoy programming, and to be happy. That is the primary purpose of Ruby language."</cite>


 ####What is Ruby?

Ruby is a powerful, flexible programming language you can use in web/Internet development, to process text, to create games, and as part of the popular Ruby on Rails web framework. Ruby is:

High-level, meaning reading and writing Ruby is really easy—it looks a lot like regular English!

Interpreted, meaning you don't need a compiler to write and run Ruby. 

The interpreter is the program that takes the code you write and runs it. You type code in the editor, the interpreter reads your code, and it shows you the result of running your code in the console (the bottom window on the right).

Object-oriented, meaning it allows users to manipulate data structures called objects in order to build and execute programs. We'll learn more about objects later, but for now, all you need to know is everything in Ruby is an object.

Easy to use. Ruby was designed by Yukihiro Matsumoto (often just called "Matz") in 1995. Matz set out to design a language that emphasized human needs over those of the computer, which is why Ruby is so easy to pick up. Ruby is a combination of Perl, Smalltalk, Eiffel, Ada and Lisp. His goal was to make Ruby natural not simple in a way that mirrors life.

Ruby is a perfect Object Oriented Programming Language. The features of the object-oriented programming language include:

Data Encapsulation:

Data Abstraction:

Polymorphism:

Inheritance:




####Variables in a Ruby:

Ruby provides four types of variables:

Local Variables: Local variables are the variables that are defined in a method. Local variables are not available outside the method. You will see more details about method in subsequent chapter. Local variables begin with a lowercase letter or _.

Instance Variables: Instance variables are available across methods for any particular instance or object. That means that instance variables change from object to object. Instance variables are preceded by the at sign (@) followed by the variable name.

Class Variables: Class variables are available across different objects. A class variable belongs to the class and is a characteristic of a class. They are preceded by the sign @@ and are followed by the variable name.

Global Variables: Class variables are not available across classes. If you want to have a single variable, which is available across classes, you need to define a global variable. The global variables are always preceded by the dollar sign ($).

```
tree_name = "pine"
$car_name = "Peugeot"
@sea_name = "Black sea"
@@species = "Cat"

p local_variables
p global_variables.include? :$car_name
p self.instance_variables
p Object.class_variables

In Ruby we name variables with snake_case

this_is_an_example_of_snake_case = "it uses underscores"
```


### Follow along!

As we experiment with Ruby syntax, you should follow along and try things yourself. Do what we do, but feel free to mess around and try your own little experiments too.

We're gonna use IRB, our Interactive Ruby Shell, so we can type some Ruby commands and see exactly what happens in real time, and you can follow along and code.

Open up your terminal, and from anywhere, type `irb`
![IRB in Terminal](https://cloud.githubusercontent.com/assets/25366/8418624/52d220f6-1e69-11e5-8e3f-bcc902944475.png)


## The Beauty of Ruby - Intro (5 mins)

There are a few general points to know about Ruby, and then we're going to be comparing the details of writing Ruby to what you already know in JavaScript.

We'll go over a bunch of basics you need to know in the next two days.

One of the things that's important to people who write code in Ruby is how the code _reads_. Rubyists are known for wanting beautiful code, and writing it in a way that reads as much like normal English as possible. That's part of what makes it great for beginners, is that it's instantly readable.

Check out this example:

```ruby
def make_a_sentence(words)
  words.join(' ') + "!"
end

make_a_sentence(['You', 'are', 'already', 'experts'])
# => "You are already experts!"
```

Without knowing anything about Ruby you can probably sort of understand how all this works. Nice, right?

> **Awesome Detail:** You might notice something interesting – where are the semicolons? You don't need them!

> Ruby is a lot more forgiving than JavaScript to newbies when it comes to details like that. In the end you'll find you have an appreciation for both, but for now let's relish forgetting the ';'

## Data Types - Demo (15 mins)

**Question:** What data types have you guys been using in Ruby? Let's write them on the board.


Now, let's see which of those are similar in Ruby, and which are different.

- `true` or `false` are still booleans _(technically **TrueClass** / **FalseClass**)_
- `nil`, the equivalent of _nothing_ _(technically **NilClass**)_
- there's no Undefined object. _If something is undefined it'll just say so._
- `16.2` is a **Float** and`1` is an **Integer** _(technically a FixNum, but you can consider it the same thing)_
- `"hello world"` is still a **String**
- `[1,2,3,4]` is still an **Array**
- `{keys: ['some', 'values'] }` is called a **Hash**, but works the same

Most importantly, **in Ruby, _everything_ is an object**. We'll talk about that in more detail later, but that means that each of the above data types have methods & properties just like our JS objects did.

#### Let's recap our data types in Ruby:

- **Booleans** are written as `true` and `false`
- **Integers** are written as `12`
- **Floats** are written as `9.45`
- **Strings** are written as `"awesome"`
- **Arrays** are written as `['x','y','z']`
- **Hashes** are written as `{key: 'value', thing: true, stuff: [1,2,3]}`

#### Duck-typing

Unlike JavaScript, Ruby has both and Integer and a Float class. This creates some interesting results! Let's take a look in IRB:

What happens if we do:

```ruby
5 / 2
=> 2
```

Have we broken Ruby? No, we have given ruby two Integers (numbers with no decimal places) so ruby gives us an Integer back.

However, if we divide an Integer by a Float:

```ruby
5 / 2.0
=> 2.5
```

This is called "Type Coercion" also known as "Duck Typing"; Ruby now knows that we want a Float back.

If an object quacks like a duck (or acts like a string), just go ahead and treat it as a duck (or a string).

#### Converting between data-types

If we want to convert one data type to another in Ruby, there are some built-in methods that we can use. We'll take a look at built-in methods in more detail in a later lesson, however for the minute let's use them and see the result:

```ruby
# Converting an Integer to a String
1.to_s
=> "1"

# Converting a String to an Integer
"10".to_i
=> 10
```

These type-conversion methods usually start with `.to_`.

#### Oh look, comments.

It's worth noting that will comments in JS look like this:

```js
// I'm a comment
```

Ruby's are like this:

```ruby
# No, I'm a comment
```

Since you guys will be making a habit of commenting your code (so that other developers can read it and understand why you wrote it how you did), that'll be useful.

#### Fun Tip: Our strings have a superpower!

One super awesome trick that you will undoubtedly use all the time comes from our friend, the **String** object.

It's called **string interpolation** – and it lets us build complicated strings without having to add them together the old fashioned way.

We used to have to do this:

```ruby
first = "Ben"
last = "Franklin"
first + " " + last # => Ben Franklin
```

That works, but this is way cooler:

```ruby
first = "Ben"
last = "Franklin"
"#{first} #{last}" # => Ben Franklin
```

So so useful. It works with anything – any code can run in those brackets, and it'll evaluate and turn into a string. Right??

## Variables - Codealong (25 mins)

Just like JavaScript (and literally every programming language), **we're gonna need some variables to hold stuff.**

_Unlike_ JavaScript, Ruby's variables don't need to be declared.

Where you're now used to:

```js
var genius = "me";
```

We can skip right to the good stuff:

```ruby
genius = "me"
```

Important to know how to use 'em. But that's only one type of variable, and there are a few.

### Types of Variables

Variables, of course, are just placeholders.

Let's talk about the different types of variables you'll encounter in Ruby. You'll need to use all of them at some point, but some more than others.

In these examples, we'll defined a variable, and then we'll write a tiny quick method that just spits that variable out, to see if it works.

#### Local Variable

A local variable (lower_snake_case) is a quick placeholder, and gets forgotten as soon as your method or function is over.

```ruby
some_variable = "donuts"

def some_method
  some_variable
end

some_variable # => "donuts"
              # because we're using it in the same place we defined it

some_method   # Run our method, when it was defined outside that method –
              # NameError: undefined local variable [blah blah blah]
```

These are great when you just need to temporarily store something or quickly give something a readable variable name, but won't need it later.

#### Instance Variable

An instance variable (lower_snake_case) is a variable that is defined in an instance of an object. That's not meant to be a fancy term - an instance is just an example of an object, one thingy in the great world of things.

```ruby
@some_variable = "donuts" # "donuts"

def some_method
  @some_variable
end

@some_variable # => "donuts"
some_method # => "donuts"
```

Remember that it works this way, because when we get to Objects & Methods later this week, you'll see that instance variables let us store a variable once and use it however many methods we need inside an object.


#### Constant

Mostly, we're able to change what a variable's holding if we so choose – constants are designed for the opposite. Constants are meant to be placeholders that _never change_.

```ruby
SOME_CONSTANT = "donuts" # "donuts"

def some_method
  SOME_CONSTANT
end

SOME_CONSTANT # => "donuts"
some_method # => "donuts"

SOME_CONSTANT = "awesome" # warning: already initialized constant
```

We can use a constant anywhere in a Ruby application – inside a method, outside a method, across objects & a whole app. But keep in mind, it's meant to be defined _only once_, so we'll use it for things like storing application settings, or other stuff we don't intend to change.
## If/Else in Ruby - Intro (15 mins)




```ruby
heroic = true

def do_something_heroic
  # some code
end

if heroic == true
  do_something_heroic
end

# same thing, parentheses are optional in Ruby
if(heroic == true)
  do_something_heroic
end
```

Well that seems easy. Just for clarity, these two things are exactly the same when we've got something returning `true`/`false`

```ruby

# totally true and obvious
if heroic == true
  do_something_heroic
end

# exactly the same, but nice shortcut
# leaving it off assumes we mean `heroic == true`
if heroic
  do_something_heroic
end
```

Of course, if we need to do something when it isn't true, we've got good ol' `else`.

```ruby
if heroic
  do_something_heroic
else
  do_something_evil
end
```

But there's a neat shortcut in Ruby for when we only need to use a conditional for one line, or for when we don't need an else. It's called an _inline_ conditional.

```ruby
# totally the same
if heroic
  do_something_heroic
end

# totally the same
do_something_heroic if heroic == true

# totally the same, just shorter!
do_something_heroic if heroic
```

Nice, right? Still easy.

Now what if you're looking to see if something something _isn't_ true? **In english, how do you tell someone to do something if a condition is not true?**

```ruby
heroic = true

# we'll always have opposite-speak, of course
# if heroic tendencies are not noble & true, do something evil
if heroic != true
  do_something_evil
end

# same thing, using bang (!whatever) to inverse what we mean
# do something evil if you're not heroic
do_something_evil if !heroic

# but we've also got 'unless'
# unless you're some heroic weirdo, do something evil, it's more fun
unless heroic
  do_something_evil
end

# oh look, it works inline, too
# do something evil unless you're a heroic weirdo
do_something_evil unless heroic
```

##Ruby Case Statements
```
case expression
[when expression [, expression ...] [then]
   code ]...
[else
   code ]
end
```

Compares the expression specified by case and that specified by when using the === operator and executes the code of the when clause that matches.

The expression specified by the when clause is evaluated as the left operand. If no when clauses match, case executes the code of the else clause.

A when statement's expression is separated from code by the reserved word then, a newline, or a semicolon.

Thus:

```
case COLOR
when "black"
   stmt1
when "white"
   stmt2
else
   stmt3
end

```
is basically similar to the following:

```
COLOR = "grey"
if COLOR == "black"
   stmt1
elsif COLOR == "white"
   stmt2
else
   stmt3
end
```




## Truthy & Falsey - Independent Practice (15 mins)

Now, true & false are useful, but you'll more frequently be working with **truthy** and **falsey**.

_Who knows the difference?_

While `true` is a direct boolean that we can assign, **truthy** gives us a boolean from _evaluating something_. Same goes for **falsey**, it comes from some sort of expression that asks the question, _"Does this evaluate to true?"_

In `irb`, take 5 minutes to try conditionals _other_ than `true` and `false`. What happens when:

- What happens when a variable is a string?
- What happens when a variable is a number?
- What happens when one number is bigger than another? Smaller?
- What happens when you're asking if two strings are the same?
- What happens when a variable even exists? One you haven't defined?
- What happens when something's nil?

## Truthy & Falsey - Discussion (10 mins)

Let's talk about what you found out. What did you learn about truthy & falsey & conditionals in Ruby?

## And/or - Codealong (20 minutes)

To wrap it all up, we're gonna need to kick it up a notch - we're gonna talk about _combining_ conditionals, and conditional _fallbacks_. 

### && (_and_ operator)

Just like in JS, we can combine conditionals really easily with double ampersands. This tells us _both_ conditions need to be true to go on.

```ruby
delicious = true
healthy = false

if delicious && healthy
  "eat that food"
end

if (delicious == true) && (healthy == false)
  "eat it anyway"
end

# oh look, optional parentheses!
if delicious == true && healthy == false
  "no really, who cares if it's healthy? eat it"
end
```

### || (_or_ operator)

Now how about if you want to try something else when a condition doesn't work? Let's see what we mean:

```ruby
delicious = false
healthy = true

if delicious || healthy
  "eat that food"
end

# mix and match what you've learned!
"eat it" if delicious || healthy

```

### Fun Bonus!
You can actually combine _assigning a variable_ with our || operator for a super useful Ruby shortcut

```ruby
awesome ||= 'this donut'

# same as writing something like
awesome = 'this donut' unless awesome
```

## Conclusion (5 mins)
- Describe the difference between truthy & true.
- What are two ways you could write an if statement? What about an unless statement?
- How do you combine conditionals?
- How do you write an if statement where if the first conditional fails, the second will still work?