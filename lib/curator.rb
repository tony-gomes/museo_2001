class Curator
  attr_reader :photographs, :artists
  def initialize()
    @photographs = []
    @artists = []
  end

  def add_photograph(photograph)
    @photographs << photograph
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.select { |artist| artist.id == id }.first
  end
end
