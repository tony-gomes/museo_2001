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

  def photographs_by_artist
    @photographs.reduce({}) do |results, photograph|
      artist_object = @artists.select { |artist| artist.id == photograph.artist_id }.first

      results[artist_object] = [] unless results.has_key?(artist_object)

      results[artist_object] << photograph
      results
    end
  end

  def artists_with_multiple_photographs
    photographs_by_artist.reduce([]) do |results, (artist, photographs)|
      results << artist.name if photographs.length > 1
      results
    end
  end

  def photographs_taken_by_artist_from(country)
    photographs_by_artist.reduce([]) do |results, (artist, photographs)|
      if artist.country == country
        photographs.each { |photograph| results << photograph }
      end
      results
    end
  end
end
