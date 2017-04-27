---
title: Objects & Methods in Ruby
type: lesson
duration: 1.25
creator:
    name: Tony Guerrero
    city: NYC
competencies: OOP in Ruby
---

# Objects & Methods in Ruby

### Objectives

- Create custom classes in Ruby
- Use Getter and Setter Methods
- Introduction to attr_reader, attr_writer, attr_accessor
- Understand the difference between instance and class methods
- A quick look at class constants


## Intro (15 mins)

- Everything in Ruby is an object
  - that means that everything has properties and methods contained inside it
  - even the data types you're used to are objects, and we're gonna mess 'em up today to prove it
  - literally everything "inherits" from the Object Class, which just like the real life gene pool, means it gets all it's parents traits


We know that we can create an object using the one-at-a-time  ```Object.new```:

	$ irb
	Object.new
	=> #<Object:0x007fd0f126cb58>

However, we want to be able to design our own objects with classes so we can create lots of them.

#### How to make objects the same but different?

Everyone in the room is an example of a Person class, however we all have different names.

We need a way of creating new objects and storing different information inside each object so that they can become individual.

Information and data associated with an object embodies the **state** of that object. We need to be able to:

#### Draw on board

- **Set**, or reset the state of an object (Say to a person, your name is "Dave")
- **Get**, read back the state (What is your name? It's "Dave")

## Codealong - Creating an instance of the Object Class (20 mins)

Let's start with something fun & simple so you can get the hang of it.

```ruby
class Cart
end
```

There's no real information in there yet, but now that we've defined it, exists. How do we make a new Cart, then?

```ruby
my_halal = Cart.new
```

> Nice, that's called initializing a new _instance_. When thinking in objects, we consider this _class_ kind of like a blueprint for all other carts (or objects) we make, and an _instance_ is a clone of that class.

> For example, you'd consider the chair you're in now a single _instance_ of _a_ chair - it was created using the known traits of a chair. You would consider the concept of a chair, in general, the class.  All chairs are create using the known traits of the Chair Class, or the concept of a chair.

Using code, let's see if we can find a way to describe what carts are all about. How would we do this if it were a hash? Maybe something like:

```rb
my_hashed_halal_stand = {
  color: "yellow",
  opened_in: 1999,
  manager: "Tony Guerrero",
  money: true
}
```

Those are all excellent properties, let's see how we'd make those into _attributes_ of our object.

```ruby
class Cart
  def color
    "yellow"
  end
  def opened_in
    1999
  end
  def manager
    "Tony Guerrero"
  end
  def accepts_credit_cards
    true
  end
end

my_halal_stand = Cart.new
my_halal_stand.color # => yellow
my_halal_stand.manager # => Tony Guerrero
my_halal_stand.money #=> True
# etc.
```

Excellent, we call those "getters" or "getter methods", because they're getting information from inside our object, but the problem _here_ is that our info is hardcoded.

Imagine we're making multiple instances of the model - we want a lot of halal stands - we might need to change who the manager is for each instance of the halal stand.

Luckily Ruby objects come with their own storage and retrieval mechanism for these types of values, called **instance variables**.

Instance variables work exactly the same as standard variables, you assign values to them, do things with them and read them back. However, they have a few differences:

- Start with an ```@``` sign
- Are only visible to the object to which they belong
- An instance variable defined in a class can be used in any other method in that class.


```ruby
class Cart
  def color
    "yellow"
  end
  def opened_in
    2015
  end
  def accepts_credit_cards
    true
  end

  # getter for "manager"
  def manager
    @manager # this could, for the record, be named whatever you like, but it's best to keep it obvious & simple
  end

  # setter for "manager"
  def manager=(the_name_of_my_manager)
    @manager = the_name_of_my_manager
  end

end
```

That's interesting – it's sort of just a normal method with one argument, it just happens to have an = in the name. `manager=` instead of just `manager`

Let's see it in action.

```ruby
my_halal = Cart.new
my_halal.manager # => nil, we haven't set it
my_halal.manager = "Rachel" # hey, look manager=, just with a space
my_halal.manager # => "Rachel"
```

That's fantastic. Now if we made another, separate instance, we could have two different halal stands, both _instances_ of our blueprint _class_.

## Independent Practice (15 minutes)

We're gonna try a little memory exercise. Take 1 minute and make sure what we've done so far is stuck in your memory. Remember the important pieces - we're about to close our computers.

Now, with a marker on the desk, and only from memory, write out a class that defines a student in this room. Think of it first as a blueprint, and then as the actual person. Pick at least one attribute, write a getter & a setter on your desk. Then write out how you'd get & set that attribute beneath it.

When you're done, open up your computer, run it in IRB, and test whether your memory got it all right.

## Some important details – Codealong (5 minutes)

#### Faster Coding Getters/setters

Now that you're experts on getters & setters, you should know that you don't always have to code them by hand. Ruby comes with a shortcut to make using them faster:

```ruby
class Cart
  attr_accessor :color, :opened_in, :manager, :money
  # there's also just attr_reader for getters & attr_writer for setters
end
```

That gives you getters & setters for each of those attributes. A little faster, yeah?

Add this an ```initialize``` method to your class:


```ruby
class Cart
  attr_accessor :color, :opened_in, :manager, :money
  # there's also just attr_reader for getters & attr_writer for setters
  
  def initialize(color,opened,manager)
  	@color = color
  	@opened_in = opened
  	@manager = manager
  	@money = false
  end
end
```
Everytime you instantiate a new instance by calling ```.new``` the ```initialize``` method will run. However, it does mean that ```.new``` will now need to take a new argument:

You can think of ```.new``` as a sort of alias for ```.initialize```.

```
taco_truck = Cart.new("blue",2015,"Esmery")
puts taco_truck.manager
```
	
**Note**: The name of the variable being passed into the ```.initialize``` method and the instance variable don't need to be the same.

##We Do: Class variables

**Class variables** are variables which are shared between all instances of a class. Class variables are prefixed with two ```@``` characters (```@@```).

**Note**: Generally, class variables are considered a bad idea. Most of the time you don't need to use them.

Let's define a class variable:

```
@@all_carts = []
```
	
It doesn't make sense that an instance method can change this value, althought it could. To work with this class variable, we should use a class method.

<br>

##We Do: Class methods
So far, all of these methods we have been creating have been ```instance methods```.

Let's define a class getter method:

```
def Cart.all
	if @@all_carts.empty?
		puts "No carts created.."
	else
  		@@all_carts 
  	end 
end
```

And in the initialize method, that only runs once, let's add:

```
@@all_carts << self
```
	
We can call this at the bottom using:

```
puts Cart.all
```
	
Let's make it more obvious:

```
puts Cart.all
Cart.new("Red",2000,"Rachel")
puts Cart.all
```

#### Self

The problem with defining a class method using the class name is that if you change the name, you have to change all the methods.

We can instead use the keyword ```self```

```
def self.all
  @@all_carts
end
```
    
```self``` refers to the object that you are currently inside, in this case the class itself.    
  
<br>

##I Do: Class Constants

Lastly, when you know you have some information that is not going to change in your class, you can use a constant.

It is defined without using ```@``` or ```@@```. By convention, we write the name of class constants in all-caps.

```
DEFAULT_MENU = ["Chicken","Lamb","Combo","Burger","Hotdog","Rice"]
```
	
You can access it outside the class using, double-colon syntax ```::```

```
puts Cart::DEFAULT_MENU
```

Or inside the class using the variable

```
  def initialize(color,opened,manager)
  	@color = color
  	@opened_in = opened
  	@manager = manager
  	@money = false
  	@@all_carts << self
  	puts "Our specialized menu #{DEFAULT_MENU}"
  end
```  	
  	
If you try to change the constant's value, it will work, which is a behavior that you probably only see in ruby, with every other language, if you try to re-assign the value of a constant, the program will throw an error, with ruby, only a warning will be raised. 


##We Do: Instance vs class methods (5 minutes)


#### Choose a person in the class

To chosen person: 

> <cite>"You are an instance of a Person class. Many of the basic things you can do, everyone else can do because they are also instances of a Person class."<cite>

> <cite>"Can you please raise your hand?

Chosen person raises their hand.

> <cite>"Other instances of the Person class haven't been asked to do anything because I've sent you an ```instance method```."

> <cite>"However, if I asked every Person to raise their hand... Class, please raise your hands..."

Everyone raises their hands.

> <cite>"This is an example of a ```class method```."
	
Actually, if we were being exact - all people would have to raise their hands.
	
<br>


## Conclusion (5 mins)

Later on, we'll see some libraries that use this sort of stuff behind the scenes – we'll be creating _models_, which are just fancy word for classes, in a larger application, that we can use to instantiate objects and save to a database.

For now, playing around and creating regular old Ruby objects, initializing them & creating instances, and writing getters & setters will give us a good foundation for creating more advanced models down the road.

- How do you define a Ruby object from scratch?
- What's a getter for? What's a setter for?
- What sort of variable do you use inside an object to share information between methods?
- What's initializing? What's an instance?
