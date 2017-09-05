require_relative '../lib/base'
require_relative '../lib/db_connection'


ARTISTS_SQL_FILE = 'artists.sql'
ARTISTS_DB_FILE = 'artists.db'

"rm '#{ARTISTS_DB_FILE}'"
"cat '#{ARTISTS_SQL_FILE}' | sqlite3 '#{ARTISTS_DB_FILE}'"

RubyRM::DBConnection.open(ARTISTS_DB_FILE)

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
