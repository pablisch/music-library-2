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
end