{{music_library_album}} Model and Repository Classes Design Recipe.

1. Design and create the Table

Table: albums

Columns:
id | title | genre

2. Create Test SQL seeds

-- (file: spec/seeds_{table_name}.sql)
>> spec/seeds_albums.sql

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

```sql
TRUNCATE TABLE albums RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO albums (title, release_year, artist_id) VALUES ('Future Days', '1974', 1);
INSERT INTO albums (title, release_year, artist_id) VALUES ('Tell Her', '1969', 2);
```
Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

To insert this data into your test database => psql -h 127.0.0.1 <your_database_name>_test < seeds_{table_name}.sql

3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

```ruby
# model class
# in lib/album.rb
class Album
end

# repository class
# in lib/album_repository.rb
class AlbumRepository
end
```

4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
class Album
  attr_accessor :id, :title, :release_year, :artist_id
end
```

5. Define the Repository Class interface
```ruby
class AlbumRepository
  def all
    # executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM artists;
    # returns an array of album objects as hashes
end
```

6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.
```ruby
repo = AlbumRepository.new

albums = repo.all # an array of Albums objects
albums.length # => 2
albums.first.id # => '1'
albums.first.title # => 'Future Days'
```

7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.
```ruby
def reset_albums_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

before(:each) do 
  reset_albums_table
end
```

end
8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.