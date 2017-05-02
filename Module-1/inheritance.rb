require "pry"
module Walkable
  def initialize(name)
    # @age = age
  end
end
class Animal
  include Walkable
  attr_accessor :name
  def speak
    puts "I'm an Animal"
  end
  def initialize(name,age)
    @name = name
    @age = age
  end
  def combine_info
    @name + " " + @age
  end
  def say_info

    self.combine_info
  end
end

class Person
  extend Walkable
  # attr_accessor :age
  def initialize()
    # @age = age
  end
  def speak
    puts "I'm a person"
    super
  end
end
class Dog
  prepend Walkable
  # attr_accessor :age
  def initialize(name)
    # @age = age
  end
  def self.walk
    puts "walking from class"
  end
  def speak
    puts "I'm a dog"
    super
  end
  def walk
    puts "walking a dog"
  end
end
binding.pry
