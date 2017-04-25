---
title: Ruby Basics
type: lesson
duration: "1hr"
creator:
    name: Tony Guerrero
    city: NYC
competencies: Ruby - Hashes, Arrays, Loops
---



#Hashes, Arrays, Loops
##OBJECTIVES
* Be able to CRUD a Hash in Ruby
* Be able to CRUD an Array in Ruby
* Be able to iterate through Hashes and Arrays in Ruby
* Be able to work with while and until loops in Ruby
* Be able to work with conditionals in Ruby

---
##Group Exercise
We're going to split up into groups and spend 20 minutes researching, exploring, and discussing some of the fundamental facets of Ruby.  Then each group will teach their topic to the rest of the class and demonstrate these concepts using irb or by running a Ruby program in the terminal.

###Group 1 - Arrays!
Tell us all about how to use arrays in Ruby.  You should make sure that you are prepared to explain and demonstrate:

* how to create arrays in Ruby
* how to add items to an array
* how to remove items from an array
* how to iterate over an array
* at least three other methods available to arrays--pick the ones that you think are really cool and want to show off to the rest of us! (http://ruby-doc.org/core-2.1.5/Array.html might be a helpful resource...hint, hint)

###Group 2 - Hashes!
Tell us all about Ruby hashes!  You should make sure that you are prepared to explain and demonstrate:

* what a hash is
* how to create a hash using the hash rocket syntax and the newer syntax that was added in Ruby v1.9
* how to create, add, and remove items from a hash
* what symbols are and why we use them with hashes

###Group 3 - Methods!
Tell us all about writing custom methods in Ruby.  You should be prepared to explain and demonstrate:

* the syntax for writing a method in Ruby
* how you write a method that takes parameters
* how you call methods (ones that take parameters and ones that don't)
* the `return` keyword
* a basic method that you wrote that takes at least one parameter

###Group 4 - Loops!
Tell us all about how to write loops in Ruby.  You should be prepared to explain and demonstrate:

* how to write an each loop , define x Times
* how a while loop works and how to write one
* how a until loop works and how to write one
* how a for in loop works and how to write one

--
###Hashes

Basic Hash Construction

```
* Using the hash rocket syntax

sample_hash   = {'one'=>1,'two'=>2}
sample_hash_2 = {:one=>1, :two=>2}

* Using colons to create a hash will create the keys as symbols

sample_hash_3 = {one:1,two:2}

```

Taking it to another level

```
* How to access a value (have to use bracket notation)

sample_hash_4 = {'one'=>1,'two'=>2,'three'=>3,'four'=>4,'five'=>5}
sample_hash_4["one"]  #=> Returns 1
sample_hash_4["five"] #=> Returns 5

* How to change the value of an element

sample_hash_4['one'] =  10


```

Methods to Know

* Creating and deleting elements from Hash

```
* Adding elements. Take note that keys can entered as strings or symbols and 
Ruby considers them to be different. Keep this in mind later when we work on 
creating/consuming APIs with Rails.

sample_hash_5 = {one:1,two:2}
sample_hash_5[:three]=3
sample_hash_5['three']=3

sample_hash_5 #=> returns
{:one=>1, :two=>2, :three=>3, "three"=>3}

sample_hash_5.delete("three")

```

* Size

```
sample_hash_6 = {one:1}
sample_hash_6.size #=> returns 1
sample_hash_6.length #=> also returns 1

```

* Other useful methods

```
sample_hash_7 = {'dog'=>'mammal','parakeet'=>'bird','tuna'=>'fish'}

sample_hash_7.keys #=> Returns an array with all keys
["dog", "parakeet", "tuna"]

sample_hash_7.values #=> Returns an array with all the values
["mammal", "bird", "fish"]
```

####EXERCISE!
```
Santa Claus is preparing his Xmas list...

Bobby(yoyo), Gretchen(kendama), Billy(Xbox), Maryam(Bicycle)

*Create a hash where the child's names are the keys and the toy they want is the value. Use the Hash methods you've learned to create an array with the children's names and another array with the children's presents.

**Bonus -- Imagine Santa wants to list the presents as the keys and the children's names as the values. There is a built-in method that will do this for us. Use Google to figure out how to do this.

```

---

###Arrays
Basic Array Construction

```
#Creating a new instance of the Array class

first_array = Array.new 
#=> []

#Using the literal constructor
	
second_array = [] 
#=> []

```

Taking it to another level

```
first_array = Array.new(3)
#=> [nil, nil, nil]

first_array = Array.new(3,'hello')
#=> ["hello", "hello", "hello"]

second_array = ['hello', 'hello', 'hello']
#=> ["hello", "hello", "hello"]

third_array = Array(1..5)
#=> [1, 2, 3, 4, 5]
```

Methods to Know

* Push, pop, shift, unshift, delete

```
sample_array = [1]
sample_array.push(2,3) #=>[1, 2, 3]
sample_array.pop #=> returns 3, array is now transformed

sample_array.unshift(0) #=> [0, 1, 2]

sample_array.shift #=> returns 0, but array is transformed

sample_array #=> [1,2]

sammple_array.delete(1) #=>[2]
sample_array.delete_at(0) #=>2

```
* First, last

```
sample_array = Array(1..5) #=> [1,2,3,4,5]
sample_array.first #=> 1
sample_array.last #=> 5
```

* Size

```
first_array = [1,2,3]
second_array = []

#The size and length arrays do the same thing
first_array.size #=> 3
second_array.length #=> 0

first_array.empty? #=> false
second_array.empty? #=> true

```


---

###Loops

* While loop

```
n = 1
while n < 11
  puts n
  n += 1
end
```

* Until loop

```
n = 1
until n > 10
  puts n
  n += 1
end
```

* Each iterator with code block and do block

```
sample_array = Array(1..5)
sample_array.each{|elem| puts elem}

sample_array.each do |elem|
  puts elem
  puts "The long way!!!"
end
```

* For in loop

```
for i in 0..5
   puts "Value of local variable is #{i}"
end
```
Output:

```
Value of local variable is 0
Value of local variable is 1
Value of local variable is 2
Value of local variable is 3
Value of local variable is 4
Value of local variable is 5
```



* Map iterator with code block and do block

```
sample_array_2 = Array(1..5)
sample_array_2.map{|elem| elem ** 2}

sample_array_2.map do |elem|
  puts elem ** 2
  puts "The long way!!!"
end
```

* The difference between #map and #each is in what they return.
 #each returns the original array and map returns a transformed
 array. Also note that map & each are available for hashes

```
each_example = [2,3,4].each{|elem| elem ** 2}
map_example  = [2,3,4].map{|elem| elem ** 2}

p each_example
p map_example

each_example_2 = {two:2,three:3,four:4}.each{|key,value| elem ** 2}
map_example_2 = {two:2,three:3,four:4}.map{|key,value| elem ** 2}

p each_example_2
p map_example_2
```
