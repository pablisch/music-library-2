require_relative './artist'

class ArtistRepository
  def all
    sql = 'SELECT id, name, genre FROM artists;'
    result = DatabaseConnection.exec_params(sql, []) # sends the sql request

    artists = [] # creates new array

    result.each do |record| # iterates over the query results
      artist = Artist.new # instantiates a new Artist object
      artist.id = record['id'].to_i # adds values from the hash result
      artist.name = record['name']
      artist.genre = record['genre']

      artists << artist # pushes each Artist into the artists array
    end

    return artists # returns the array of Artist objects
  end

  def find(id)
    sql = "SELECT id, name, genre FROM artists WHERE id = $1;"
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    entry = result[0]
    artist = Artist.new
    artist.id = entry['id']
    artist.name = entry['name']
    artist.genre = entry['genre']
    return artist
  end

  def create(artist)
    sql = "INSERT INTO artists (name, genre) VALUES ($1, $2);"
    params = [artist.name, artist.genre]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  def delete(id)
    sql = "DELETE FROM artists WHERE id = $1;"
    params = [id]
    DatabaseConnection.exec_params(sql, params)
    return nil
  end

  def find_with_album(artist_id)
    sql = 'SELECT artists.id AS "artist_id", artists.name, artists.genre, albums.title, albums.release_year, albums.id AS "albums_id"
    FROM artists
    JOIN albums
    ON albums.artist_id = artists.id
    WHERE artists.id = $1;'
    params = [artist_id]
    result_set = DatabaseConnection.exec_params(sql, params)

    artist = Artist.new
    record = result_set[0]
    artist.id = record['artist_id'].to_i
    artist.name = record['name']
    artist.genre = record['genre']
    artist.albums = []
    result_set.each do |record|
      album = Album.new
      album.title = record['title']
      album.release_year = record['release_year'].to_i
      album.id = record['albums_id'].to_i
      album.artist_id = record['artist_id'].to_i
      artist.albums << album
    end
    return artist

  end
end