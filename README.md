# RubyRM

RubyRM is an Object-Relational Mapping (ORM) library modeled after Active Record.

## Try it out

- Clone this repo and open up `pry` in the terminal
- Run `load './demo/demo.rb'` to create tables for `artists`, `paintings` and `galleries`
- From here you can try commands such as `.all`, `.first`, `.last` and more

## Complete List of methods for interfacing with the database

### Base

`::all` - Returns an array of all entries in a table

`::find(id)` - Returns an entry in a table based on it's ID

`::new` - Creates an un-finalized entry for a table

`#save` - Creates new entry for a table

`#insert` - Inserts record into database  

`#update` - Updates entry in a given table


### Searchable

`#where` - Returns an array of all entries that correspond with the search value

### Associatable

`belongs_to` - sets up a one-to-one connection with a parent model

`has_many` -  sets up a one-to-many connection with a child model

`has_one_through` - sets up a one-to-one connection with a grandparent model
