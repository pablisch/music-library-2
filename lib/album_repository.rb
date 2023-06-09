require_relative './album'

class AlbumRepository
  def all
    sql = 'SELECT id, title, release_year, artist_id FROM albums;'
    results = DatabaseConnection.exec_params(sql, [])

    albums = []

    results.each do |record|
      album = Album.new
      album.id = record['id'].to_i 
      album.title = record['title']
      album.release_year = record['release_year'].to_i 
      album.artist_id = record['artist_id'].to_i 

      albums << album
    end
    return albums
  end

  def find(id)
    sql = 'SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;'
    params = [id]
    results = DatabaseConnection.exec_params(sql, params)

    record = results[0]
    album = Album.new
    album.id = record['id'].to_i 
    album.title = record['title']
    album.release_year = record['release_year'].to_i 
    album.artist_id = record['artist_id'].to_i 
    return album
  end

  def create(album)
    sql = 'INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3)'
    params = [album.title, album.release_year, album.artist_id]
    DatabaseConnection.exec_params(sql, params)
  end

  def delete(id)
    sql = 'DELETE FROM albums WHERE id = $1;'
    params = [id]
    DatabaseConnection.exec_params(sql, params)
  end

  def update(album)
    sql = 'UPDATE albums SET title = $1, release_year = $2 WHERE id = $3;'
    params = [album.title, album.release_year, album.id]
    DatabaseConnection.exec_params(sql, params)
  end
end