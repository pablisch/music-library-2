{{🦠DATABASE : 🦠TABLE }} Model and Repository Classes Design Recipe.

## NOTES:

> Make sure that the {DATABASE NAME} has been entered into the appropriate place in:
> spec_helper.rb > DatabaseConnection.connect('your_database_name_test')

## 1. Design and create the Table

Table: albums

Columns:
id | title | genre

🦠 Create the table AND table_test and insert data from seed: 
```bash
psql -h 127.0.0.1

pablo=# CREATE DATABASE music_library
pablo=# CREATE DATABASE music_library_test

psql -h 127.0.0.1 your_database_name < {table_name}.sql
psql -h 127.0.0.1 your_database_name_test < {table_name}.sql
```

## 2. Create Test SQL seeds

-- (file: spec/seeds_{table_name}.sql)
>> spec/seeds_albums.sql

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

```sql
TRUNCATE TABLE albums RESTART IDENTITY; -- 🦠 TABLE NAME! 🦠 replace with your own table name.

INSERT INTO albums (title, release_year, artist_id) VALUES ('Future Days', '1974', 1);
INSERT INTO albums (title, release_year, artist_id) VALUES ('Tell Her', '1969', 2);
```

To insert this data into your test database => psql -h 127.0.0.1 <your_database_name>_test < seeds_{table_name}.sql

## 3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

```ruby
# model class FILE lib/album.rb
class Album
end

# repository class FILE lib/album_repository.rb
class AlbumRepository
end
```

## 4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
class Album
  attr_accessor :id, :title, :release_year, :artist_id
end
```

## 5. Define the Repository Class interface
```ruby
# repository class FILE lib/album_repository.rb
class AlbumRepository
  def all
    # executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM artists;
    # returns an array of album objects as hashes
end
```

## 6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.
```ruby
# rspec test for #all
repo = AlbumRepository.new
albums = repo.all # an array of Albums objects
albums.length # => 2
albums.first.id # => '1'
albums.first.title # => 'Future Days'
```

## 7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.
```ruby
require 'artist_repository'

RSpec.describe ArtistRepository do

  def reset_artists_table # reload method
    seed_sql = File.read('spec/seeds_artists.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_artists_table # reloads for each test
  end

  it "" do # first test
  end
end
```

end

## 8. CHECK:

> That all the relevant REQUIREs are in place:
> {table}_repository.rb > require_relative '{table}'
> {table}_repository_spec.rb > require '{table}_repository'
> app.rb > require_relative 'lib/database_connection'
         & require_relative 'lib/{table}_repository'
> spec_helper.rb > database_connection.rb
> database_connection.rb > require 'pg'

## 9. Test-drive and implement the Repository class behaviour

## 10. Code app.rb and test