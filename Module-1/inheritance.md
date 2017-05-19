---
title: Inheritance and Modules
type: lesson
duration: "1hr"
creator:
    name: Tony Guerrero
    city: NYC
competencies: Classical Inheritance
---

#Inheritance and Composition


##Quick Review:

1. What is an instance method?
1. What is self?



##Objectives:

1. Describe what inheritance is and identify the benefits & disadvantages of its use. Create  2 classes in which one class inherits from another class.
1. Create a class that can override methods from it's parent class.
1. Understand super.
2. Use modules for name::spacing.
3. Include, prepend and extend.

##Inheritance:

- Inheritance is used to indicate that one class will get most or all of its features from a parent class.
- You design the class types based on what they are.

**When is inheritance useful?**

- DRY - Don't Repeat Yourself & reuse code functionality
- Faster implementation time
- Common single source attributes

>Example: Suppose you're building an application that helps you ship goods. Many forms of shipping are available, but all forms share some basic functionality (weight calculation, perhaps). We don’t want to duplicate the code that implements this functionality across the implementation of each shipping type.

##Demo

```
class Animal
  def speak
    puts "I am an animal"
  end
end
```

```
class Person < Animal
    def initialize(age, gender, name)
        @age = age
        @gender = gender
        @name = name
    end
end
```

- Single Inheritance
    - In Ruby, a class can only inherit from a single other class. It *cannot* inherit from multiple classes.
    ![](https://draftin.com:443/images/13819?token=LgAN2Cjq0VY2E1kC14KkUjazImyXfmOTtc-EiNJbdofQ25kQLkSBtxVpde5pu1y2if0_H6LTEUeTaklH1Yjmimw)
    - Benefits and disadvantages to single & multiple inheritance
    - In Ruby, initialize is an ordinary method and inherited just like another method.

##Code-Along

```
class Box

  def initialize(w, h)
    @width = w
    @height = h
  end

  def get_area
    @width * @height
  end

end

class BigBox < Box

  def print_area
    @area = @width * @height
  end

end

1.) How would I create a box? How could I create a BigBox?
1.) How would I print the area of the BigBox?
```

##Exercise #1:
Create a Mammal class, Cat class, and Dog class. Have Cat and Dog inherit from Mammal. Include some attributes for each class and a method for mammal.

##Overriding & Super:

Demo

```
class Dog  
  def initialize(breed)  
    @breed = breed  
  end  

  def to_s  
    "(#@breed, #@name)"  
  end  
end  

class Lab < Dog  
  def initialize(breed, name)  
    super(breed)  
    #super
        #calls the method of the parent class
        #& passes all the arguments into the parent class
    @name = name  
  end  
end  

puts Lab.new("Labrador", "Ben").to_s
# .to_s is called implicitly with any puts or print or p method call  
```

- When you invoke super with no arguments Ruby sends a message to the parent of the current object, asking it to invoke a method of the same name as the method invoking super. It automatically forwards the arguments that were passed to the method from which it's called.
- Called with an empty argument list - super()-it sends no arguments to the higher-up method, even if arguments were passed to the current method.
- Called with specific arguments - super(a, b, c) - it sends exactly those arguments.

##Modules and mixins
We introduced the idea that we can describe an app with a set of object classes or models, and give each object its own file.

This allows us to break our code up by placing a method inside the relevant object definition.

However, as we learnt, since an object can only inherit methods from its parent, then that's quite limiting, as ruby classes can only inherit from one other class.

What if there's a behaviour that not every subclass needs to adopt from the superclass:

Not every mammal knows how to fly, not all of them lay eggs

My Human class inherits a lot of useful funcitonality from Mammal class, however it also would inherit a method lay_eggs or others, which would end up as a reduntant functionality, not exactly as DRY as we would like it to be.

There are cases where we'll want to include common functionality in classes that don't have a logical common ancestor.

####Example
```
require "pry"

class Human
  def walk
    puts "walking"
  end

  def speak
    puts "bla bla bla"
  end

  def leg_count
    puts 2
  end
end

class Dog
  def bark
     put "woof woof"
  end
  def walk
    puts "walking"
  end
end

class Dolphin
  def swim
     puts "i'm riding waves"
  end

  def leg_count
     puts 0
  end
end

person = Human.new
dolphin = Dolphin.new
dog = Dog.new

binding.pry
nil

```

We can see that human has a method walk and so does dog, so again we are seeing some repetition we want to eliminate: lets comment out those methods for both classes:

```
class Human
  ...
  # def walk
  #   puts "walking"
  # end
end

class Dog
  ...
  # def walk
  #   puts "walking"
  # end
end
```
We will take this functionality out into a module.

Create walkable.rb within _modules_ folder, inside this file we will declare a module, here's the syntax:

```
module Walkable
  def walk
    puts "walking"
  end
end
```
We use a keyword _module_ followed by a chosen by you name for it, don't forget and _end_. Within the module we define our methods. Usually you woud have more than one method, we'll use only one for our example.

Now, since this is a separate file, before we can use this module we need to require the file into the classes.rb file where we will be using it: `require_relative "walkable"`.

Now we can include this module in our human class and here's this is a syntax:

```
class Human

  include Walkable   #all you need to do to include the methods form the module

  def speak
    puts "bla bla bla"
  end

  def leg_count
    puts 2
  end
end
```
- include is easy enough to understand, it adds the module's methods as instance methods to it's including class. You can think of extend doing the same thing, but instead adding the methods as class methods.
- In addition to include/extend, Ruby 2.0+ adds the prepend method. prepend is similar to include, but instead inserts the module before the including class in the inheritance chain.

###Summary:

A Module is just a collection of methods. We can include it into classes or just instances so that the methods within the module are available as instance methods.

The whole point of modules (and inheritance) is that they allow us to break our code up into more manageable and understandable chunks.

Do you recall using modules… or a module? There's one extremely useful module that you all have been using called Enumerable, it was mentioned when we covered hashes, this is a documentation for it:
http://ruby-doc.org/core-2.1.2/Enumerable.html

This module is mixed into Hash and Array classes

```
irb(main):012:0> Hash.included_modules
=> [Enumerable, Kernel]

irb(main):013:0> Array.included_modules
=> [Enumerable, Kernel]
irb(main):014:0>
```
We can use _.ancestors_ method which will show the whole ancestry chain mosules and classes it inherits from:

```
irb(main):015:0> Array.ancestors
=> [Array, Columnize, Enumerable, Object, PP::ObjectMixin, Kernel, BasicObject]

[2] pry(main)> Hash.ancestors
=> [Hash, Enumerable, Object, PP::ObjectMixin, Kernel, BasicObject]
```
