# Custom ORM: Pokedex 
>***CODE ALONG***

### Learning Objectives:
- Create project environment 
- Organize files
- Setup Gemfile
- Schema migration from sql file
- Create SQLRunner
- DB Connection "string"
- Pokemon model class
- initialize
- save
- .all / .find

<br>
---
### Project Environment

Create main project folder called `POKEDEX`
![](/Users/Toneloke/Desktop/Screen Shot 2017-05-02 at 8.48.02 AM.png)

<br>

---


### Class how do we setup a Gemfile?          

>What are gemfiles?
>Versions?

```ruby
bundle init

source "https://rubygems.org"

group :development do
  gem "pry"
  gem "sqlite3"
end

bundle install
```

---

<br>

### Migration creation

First we need a .sql file to create our pokemon table

`$ touch schema_migration.sql`

Now add your create table SQL statement.

```sql
CREATE TABLE IF NOT EXISTS pokemon(id INTEGER PRIMARY KEY, name TEXT, type TEXT);
```  

---

<br>

### DB adapter
We need a way to communicate with our db in our environment file. First lets create a ruby class to do this.

`$ touch sql_runner.rb`

Now lets create 2 methods one that reads our sql file another to execute if we have multiple lines.

```ruby
class SQLRunner
  def initialize(db)
    @db = db
  end

  def execute_schema_migration_sql
    sql = File.read('db/schema_migration.sql')
    execute_sql(sql)
  end

  def execute_sql(sql)
     sql.scan(/[^;]*;/m).each { |line| @db.execute(line) } unless sql.empty?
  end
end
```

---

<br>

### Environment configuration and connections string
We need to setup bundler to use the gems we imported. 

```ruby
require 'bundler/setup'
Bundler.require(:default, :development)
require 'pry'
```
Import our runner file and pokemon model.

```ruby
require_relative "../lib/pokemon"
require_relative "sql_runner"
```

Setup our db connection

```ruby

@db = SQLite3::Database.new('./db/pokemon.db')
@db.execute("DROP TABLE IF EXISTS pokemon;")

```

Create your table migration and execute with db

```ruby
@sql_runner = SQLRunner.new(@db)
@sql_runner.execute_schema_migration_sql
```

---

<br>

### Pokemon Model
This is our ORM that will communicate with our db and query for pokemon.

```ruby           
class Pokemon
  attr_accessor :id, :name, :type, :db

  def initialize id, name, type, db
    @id, @name, @type, @db = id, name, type, db
  end

  def save
    self.db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", self.name, self.type)
    "You successfully saved #{self.name}!"
  end

  def self.all db
    all_pokemon = db.execute("SELECT * FROM pokemon")
    all_pokemon.map do |p|
      Pokemon.new(p[0],p[1],p[2],db)
    end
  end

  def self.find_by_id id_num, db
    poke_info = db.execute("SELECT * FROM pokemon WHERE id=?", id_num).flatten
    Pokemon.new(poke_info[0],poke_info[1],poke_info[2],db)
  end
end
```

---

<br>





