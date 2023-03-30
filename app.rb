require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

$first_run = true

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    system("clear") if $first_run == true
    $first_run = false
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.

    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
    @io.puts "\nWelcome to the music library manager!"
    @io.puts "\nWhat would you like to do?"
    @io.puts " 1 - List all albums"
    @io.puts " 2 - List all artists\n"
    @io.puts " 3 - Quit\n"
    @io.print "\nEnter your choice: "
    choice = @io.gets.chomp
    menu_handler(choice)
  end

  def menu_handler(choice)
    system("clear")
    if choice == "1"
      album_repository = AlbumRepository.new
      puts "\nHere is your list of albums:"
      album_repository.all.each_with_index { |album, index| puts "* #{index + 1} - #{album.title}" }
    elsif choice == "2"
      artist_repository = ArtistRepository.new
      puts "\nHere is your list of artists:"
      artist_repository.all.each_with_index { |artist, index| puts "* #{index + 1} - #{artist.name}" }
    elsif choice == "3"
      exit
    end
    run()
  end

end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end





# artist_repository = ArtistRepository.new

# artist_repository.all.each { |artist| p artist }


# album_repository = AlbumRepository.new

# album_repository.all.each { |album| p album }
