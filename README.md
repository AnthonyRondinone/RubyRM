# RubyRM

RubyRM is an Object-Relational Mapping (ORM) library modeled after Active Record.

## Try it out

- Clone this repo and open up `pry` in the terminal
- Run `load './demo/demo.rb'` to create tables for `artists`, `paintings` and `galleries`
- From here you can try commands such as `.all`, `.first`, `.last` and more

## Complete List of methods for interfacing with the database

### Base

`::all` - Returns an array of all entries in a table

- Example `Artis.all`

`::first` - Returns the first entry in the table

- Example `Artis.first`

`::last` - Returns the last entry in the table

- Example `Artis.last`

`::find(id)` - Returns an entry in a table based on it's ID

- Example `Artis.find(id)`

`::new` - Creates an un-finalized entry for a table

`#save` - Creates new entry for a table

  Example :
  ```
Painting = Painting.new
Painting.title = "Inside Out"
Painting.artist_id = 8
Painting.save
```

`#insert` - Inserts record into database  

`#update` - Updates entry in a given table

- Example `Artis.update(3, fname: "Anthony", lname: "Rondinone", gallery_id: 9)`


### Searchable

`#where` - Returns an array of all entries that correspond with the search value

- Example `Artis.where(lname: "Dali")`

### Associatable

`belongs_to` - sets up a one-to-one connection with a parent model


`has_many` -  sets up a one-to-many connection with a child model


`has_one_through` - sets up a one-to-one connection with a grandparent model

- Example

```
class Gallery < RubyRM::Base
  has_many :artists

end

class Artist < RubyRM::Base
  belongs_to :gallery

  has_many :paintings

end

class Painting < RubyRM::Base
  belongs_to :artist

  has_one_through :gallery, :artist, :gallery
end


Artist.first.paintings
Painting.last.artist
Painting.first.gallery

```
