
======
## Multiple Classes

###Learning Objectives:

- Create classes using other classes
- Use hashes and arrays as variables to store multiple objects
- Organize multiple classes using a main file

<br>
---

| **Section**      | **Timing** | **Summary** |
|------------------|------------|-------------|
| **Opening**          | 10 mins    | Quick introduction to the problem.   
| **We Do**: Model airport using custom classes  | 60 mins    | Codealong to create an airport with custom classes
| **Closure** | 10 mins | Summary of what could be improved?                              
| **Questions** | 10 mins | Any questions?


Multiple Classes
=====

##Opening

We've played with creating one custom class but we ideally want to make lots of custom classes and get them to interact with each other.

#### Instructions

The task is to create a Ruby console app to manage flights and passengers from an airport.

You must be able to:

- Add a flight
- List flights
- Remove flight
- Add passenger to flight
- List passengers of a flight

<br>

##We Do: Model airport using custom classes 

Let's model the various classes:

```
$ mkdir airport 
```
	
We need to define our classes:

```
touch airport.rb
touch flight.rb
touch passenger.rb
```

<br>

###The Airport Class

An airport needs to have:

- A name
- It needs to contain information about it's flights

In the `airport.rb` file:

```
class Airport

  attr_reader :name
  attr_accessor :flights

  def initialize(name)
    @name  = name
    @flights = []
  end
  	
end
```

#### Using an array for flights

We need a way of storing several objects, so we need a container for objects. So that's why we've used an array.

#### Using a hash?

We could use a hash here. However, for the moment let's keep things simple.
 
<br>

###The Flight Class

A flight needs to contain:

- The number of seats on the flight
- The destination of the flight
- The passengers on that flight

Add to the `flight.rb` file:

```
class Flight

  attr_reader :number_of_seats
  attr_accessor :passengers, :destination

  def initialize(number_of_seats, destination)
    @number_of_seats = number_of_seats
    @destination     = destination
    @passengers      = []
  end
    
end
```

<br>

###The Passenger class

Each passenger needs:

- A name

Add this to the `passenger.rb` file:

```
class Passenger

  attr_reader :name

  def initialize(name)
    @name = name
  end

end
```

<br>

##Make a menu

In order to do the things that the brief asks us to do we need another file, a file that will give us an user-interface.

```
$ touch main.rb
```
	
#### Requiring files
	
First, we need to `require` the other files:

```
require_relative 'airport'
require_relative 'flight'
require_relative 'passenger'
```

We then need to instantiate a new airport using the Airport class

```
airport = Airport.new("London Heathrow")
```

Let's remember the things that the airport manager wants to do:

- Add a flight
- List flights
- Remove flight
- Add passenger to flight
- List passengers of a flight

#### Creating a menu

In `main.rb` let's create a menu method:

```
def menu
  puts `clear`
  puts "*** Welcome to Heathrow Airport ***\n\n"
  puts '1 : Add a flight'
  puts '2 : List flights'
  puts '3 : Add passenger to flight'
  puts '4 : List passengers of a flight'
  puts "Q : Quit\n\n"
  print '--> '
    gets.chomp
end
```

The last line of the method will be returned, which will be the user's selection.

Next, we need to save that interaction so that we can use it:

```
response = menu
```

#### Ask question:

**Q. What control-flow technique would be useful for this?**

Answer. A case statement or a case statement and a while loop?

```
while response.upcase != 'Q'
  case response
  when '1' # Add a flight
  when '2' # List flights
  when '3' # Add passenger to flight
  when '4' # List passengers of a flight
  end

  response = menu
end
```

Let's run this with:

```
$ ruby main.rb
```

<br>

At the end, we call `response = menu` again to re-run the menu.

#### Add a flight

We need to by asking for user input.  Let's look back at what we need to create a new flight, ```number_of_seats```, ```destination```:

We need to use ```gets``` and ```chomp``` to get this input.

```
when '1' # Add a flight
  puts "How many passengers are on this flight?"
  number_of_passengers = gets.to_i
  puts "What is the flight's destination?"
  destination = gets.chomp
```

Why don't we ask for this information inside the class? Well, you need to know the name before you can create a flight.

Next, we need to add a flight to the airport array. In order to do this, we need to add a method in our airport class.

In `airport.rb`:

```
def add_flight(number_of_seats, destination)
  flights << Flight.new(number_of_seats, destination)
end
```  	
  	
#### Why in the airport class and not the flight class?

It's not the job of the flight to know about the airport. The airport stores the fights so it needs to be the one who adds the flight.
  	
Let's now let's use this instance method in ```main.rb```

```
when '1' # Add a flight
  puts "How many passengers are on this flight?"
  number_of_passengers = gets.chomp.to_i
  puts "What is the flight's destination?"
  destination = gets.chomp            
  p airport.add_flight(number_of_passengers, destination)
```

For the last line we have used ```p``` instead of ```puts```

#### Problem?

The code runs fine, but nothing is displayed becuase the code runs straight on.

Let's add ```gets``` to wait for a keypress. Nothing is done with this keypress, it just stops the program running.

```
when '1' # Add a flight
  puts "How many passengers are on this flight?"
  number_of_passengers = gets.chomp.to_i
  puts "What is the flight's destination?"
  destination = gets.chomp            
  p airport.add_flight(number_of_passengers, destination)
  gets
```

#### #<Flight:0x007fb3048316e8>

After the flight is pushed into the flights array, the flights array is returned.

We can customise the way this looks by overwriting the ```.to_s``` method in the Flight class:

```
def to_s
  "#{destination} with #{number_of_seats} passengers."
end
```
  	
Then we can used ```puts``` to output the string representation of the Flight object. ```puts``` outputs a string.

```
when '1' # Add a flight
  puts "How many passengers are on this flight?"
  number_of_passengers = gets.chomp.to_i
  puts "What is the flight's destination?"
  destination = gets.chomp            
  puts airport.add_flight(number_of_passengers, destination)
  gets
```	
  	
#### List flights

Next, we need to create a method to list flights. We can access the flights using the instance method ```.flights``` in the Airport class.
	
Lets create a method to display the flights in ```main.rb```

```
def list_flights(airport)
  airport.flights.each_with_index do |flight, index|
    puts "#{index}.\t#{flight}"
  end
end
```
    
```each_with_index``` will allow us to access the index of the flights:

**Q. Why are we not doing this in the airport class?**

Answer: You don't want to be "puts'ing" out of a class. This suggests that the Airport class knows about the main file. But it doesn't. We take the data out of the airport class and then display it in ```main.rb```.

Let's use this in the menu:

```
when '2' # List flights
  puts "Here is a list of the flights:"
  list_flights(airport)
  gets
```

#### Add passenger to flight

In order to do this task, we need to do three things.
So let's write the pseudo-code:

1. Create a new passenger
2. Choose a flight
3. Add passenger to a flight

Let's first create the passenger:

```
when '3' # Add passenger to flight
  puts "What is the passenger name?"
  name = gets.chomp
  passenger = Passenger.new(name)
```

Then let's list the flights:

```
when '3' # Add passenger to flight
  puts "What is the passenger name?"
  name = gets.chomp
  passenger = Passenger.new(name)

  puts "What flight do you want to add a passenger to?"
  list_flights(airport)
```

Then choose a flight using ```[]```. We're just accessing an array!
   
```   
flight_number = gets.chomp.to_i
flight = airport.flights[flight_number]
```
      
Next, let's create a method to add a passenger to a flight:

```
# flight.rb

def add_passenger(passengers)
  passengers << passenger
end
```

Let's use it in the menu.

```
when '3' # Add passenger to flight
  puts "What is the passenger name?"
  name = gets.chomp
  passenger = Passenger.new(name)

  puts "What flight do you want to add a passenger to?"
  airport.list_flights
  flight_number = gets.chomp.to_i
  flight = airport.flights[flight_number]
      
  flight.add_passenger(passenger)
  puts "#{passenger.name} added to #{flight}"
  gets
```

#### List passengers of a flight

The last task is to list the passengers of a flight. 

Let's pseudo-code again:

1. List the flights
2. Choose a flight
2. Loop through the passengers array in a pretty way

Let's list the flights:

```
when '4' # List passengers of a flight
  puts "What flight do you want to list the passengers of?"
  list_flights(airport)
```

Then lets choose a flight:

```
  flight_number = gets.chomp.to_i
  flight = airport.flights[flight_number]
```

Then let's create the method to list_passengers for that flight instance:

```
def list_passengers(flight)
  flight.passengers.each_with_index do |passenger, index|
    puts "#{index}. #{passenger.name}"
  end
end
```

It's very similar to the listing flight method.

And implement in the menu:

```
when '4' # List passengers of a flight
  puts "What flight do you want to list the passengers of?"
  list_flights(airport)

  flight_number = gets.chomp.to_i
  flight = airport.flights[flight_number]

  puts "The passenger list for this flight is:"
  list_passengers(flight)
  gets
```

And we're done!

<br>

##Closure

Now this isn't perfect. Why?

1. No error handling
2. Very basic
3. Hard to work out what you are doing
4. Have to re-run the file every time
5. Memory isn't saved

But we've covered a lot of concepts here...

<br>

###Deliverable

Example of finished code in airport directory.

<br>

###Questions

Any questions?

<br>