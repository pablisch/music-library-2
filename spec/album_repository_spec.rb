require 'album_repository'

RSpec.describe AlbumRepository do

  def reset_albums_table # reload method
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_albums_table # reloads for each test
  end

  # it "returns values for Album objects" do
  #   repo = AlbumRepository.new
  #   albums = repo.all # an array of Album objects
  #   expect(albums.length).to eq(2) # => 2
  #   expect(albums.first.id).to eq('1') # => '1'
  #   expect(albums.first.title).to eq('Future Days') # => 'Future days'
  # end

  # it "returns selected Album based on id" do
  #   repo = AlbumRepository.new
  #   id_to_find = 1
  #   album = repo.find(id_to_find) # an array of Albums objects
  #   expect(album.title).to eq('Future Days') # => 'Future Days'
  #   expect(album.release_year).to eq('1974') # => 'Future Days'
  # end

  # it "creates a new album object" do
  #   repo = AlbumRepository.new
  #   album = Album.new
  #   album.title = 'Title'
  #   album.release_year = '2023'
  #   album.artist_id = '1'
  #   repo.create(album)
  #   albums = repo.all

  #   expect(albums).to include(have_attributes(
  #   title: 'Title',
  #   release_year: '2023',
  #   artist_id: '1')) # This works the same as the 'standard' code below

  #   # expect(albums[-1].title).to eq 'Title'
  #   # expect(albums[-1].release_year).to eq '2023'
  #   # expect(albums[-1].artist_id).to eq '1'
  # end

  # it "deletes an album from the db" do
  #   repo = AlbumRepository.new
  #   id_to_delete = 1
  #   repo.delete(id_to_delete)
  #   albums = repo.all
  #   expect(albums.length).to eq(1)
  #   expect(albums[0].id).to eq('2')
  # end

  # it "updates an album in the db" do
  #   repo = AlbumRepository.new
  #   id_to_update = 1
  #   album = repo.find(id_to_update)
  #   album.title = "Past Days"
  #   album.release_year = "1999"
  #   repo.update(album)
  #   updated_album = repo.find(id_to_update)
  #   expect(updated_album.title).to eq('Past Days')
  #   expect(updated_album.release_year).to eq('1999')
  # end
end