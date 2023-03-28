require 'album_repository'

RSpec.describe AlbumRepository do

  def reset_albums_table # reload method
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_albums_table # reloads for each test
  end

  it "returns values for Album objects" do
    repo = AlbumRepository.new
    albums = repo.all # an array of Album objects
    expect(albums.length).to eq(2) # => 2
    expect(albums.first.id).to eq('1') # => '1'
    expect(albums.first.title).to eq('Future Days') # => 'Future days'
  end
end