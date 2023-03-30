require 'artist_repository'

RSpec.describe ArtistRepository do

  def reset_artists_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_artists_table
  end

  xit "returns values for Artist objects" do
    repo = ArtistRepository.new
    artists = repo.all # an array of Artist objects
    expect(artists.length).to eq(2) # => 2
    expect(artists.first.id).to eq('1') # => '1'
    expect(artists.first.name).to eq('CAN') # => 'CAN'
  end

  it "returns artist and all albums by that artist" do
    repo = ArtistRepository.new
    find_by_id = 1
    artist = repo.find_with_album(find_by_id)
    expect(artist.id).to eq(1) # => '1'
    expect(artist.name).to eq('Pixies')
    expect(artist.albums.length).to eq 2
    expect(artist.albums[0].title).to eq('Future Days')
    expect(artist.albums[0].release_year).to eq(1974)
    expect(artist.albums[0].artist_id).to eq(1)
  end
end

