require_relative './artist'

class ArtistRepository
  def all
    sql = 'SELECT id, name, genre FROM artists;'
    result = DatabaseConnection.exec_params(sql, []) # sends the sql request

    artists = [] # creates new array

    result.each do |record| # iterates over the query results
      artist = Artist.new # instantiates a new Artist object
      artist.id = record['id'] # adds values from the hash result
      artist.name = record['name']
      artist.genre = record['genre']

      artists << artist # pushes each Artist into the artists array
    end

    return artists # returns the array of Artist objects
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