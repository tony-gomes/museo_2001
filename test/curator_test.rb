require_relative 'test_helper'
require './lib/curator'
require './lib/artist'
require './lib/photograph'

class CuratorTest < MiniTest::Test
  def setup
    @photo_1 = {
         id: "1",
         name: "Rue Mouffetard, Paris (Boy with Bottles)",
         artist_id: "1",
         year: "1954"
    }

    @photo_2 = {
         id: "2",
         name: "Moonrise, Hernandez",
         artist_id: "2",
         year: "1941"
    }

    @photo_3 = {
         id: "3",
         name: "Identical Twins, Roselle, New Jersey",
         artist_id: "3",
         year: "1967"
    }

    @photo_4 = {
         id: "4",
         name: "Monolith, The Face of Half Dome",
         artist_id: "3",
         year: "1927"
    }

    @artist_1 = {
         id: "1",
         name: "Henri Cartier-Bresson",
         born: "1908",
         died: "2004",
         country: "France"
    }

    @artist_2 = {
         id: "2",
         name: "Ansel Adams",
         born: "1902",
         died: "1984",
         country: "United States"
    }

    @artist_3 = {
         id: "3",
         name: "Diane Arbus",
         born: "1923",
         died: "1971",
         country: "United States"
    }

    @curator = Curator.new
  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_it_starts_with_no_photographs
    assert_equal [], @curator.photographs
  end

  def test_it_can_add_photographs
    photo_1 = Photograph.new(@photo_1)
    @curator.add_photograph(photo_1)

    assert_equal [photo_1], @curator.photographs

    photo_2 = Photograph.new(@photo_2)
    @curator.add_photograph(photo_2)

    assert_equal [photo_1, photo_2], @curator.photographs
  end

  def test_it_starts_with_no_artists
    assert_equal [], @curator.artists
  end

  def test_it_can_add_artists
    artist_1 = Artist.new(@artist_1)
    @curator.add_artist(artist_1)

    assert_equal [artist_1], @curator.artists

    artist_2 = Artist.new(@artist_2)
    @curator.add_artist(artist_2)

    assert_equal [artist_1, artist_2], @curator.artists
  end

  def test_it_can_find_artist_by_id
    artist_1 = Artist.new(@artist_1)
    @curator.add_artist(artist_1)

    artist_2 = Artist.new(@artist_2)
    @curator.add_artist(artist_2)

    assert_equal artist_1, @curator.find_artist_by_id("1")
  end

  def test_it_can_get_photographs_by_artist
    photo_1 = Photograph.new(@photo_1)
    @curator.add_photograph(photo_1)
    photo_2 = Photograph.new(@photo_2)
    @curator.add_photograph(photo_2)
    photo_3 = Photograph.new(@photo_3)
    @curator.add_photograph(photo_3)
    photo_4 = Photograph.new(@photo_4)
    @curator.add_photograph(photo_4)

    artist_1 = Artist.new(@artist_1)
    @curator.add_artist(artist_1)
    artist_2 = Artist.new(@artist_2)
    @curator.add_artist(artist_2)
    artist_3 = Artist.new(@artist_3)
    @curator.add_artist(artist_3)

    expected_artists = {
      artist_1 => [photo_1],
      artist_2 => [photo_2],
      artist_3 => [photo_3, photo_4]
    }

    assert_equal expected_artists, @curator.photographs_by_artist
  end

  def test_it_can_get_artist_names_with_multiple_photographs
    photo_1 = Photograph.new(@photo_1)
    @curator.add_photograph(photo_1)
    photo_2 = Photograph.new(@photo_2)
    @curator.add_photograph(photo_2)
    photo_3 = Photograph.new(@photo_3)
    @curator.add_photograph(photo_3)
    photo_4 = Photograph.new(@photo_4)
    @curator.add_photograph(photo_4)

    artist_1 = Artist.new(@artist_1)
    @curator.add_artist(artist_1)
    artist_2 = Artist.new(@artist_2)
    @curator.add_artist(artist_2)
    artist_3 = Artist.new(@artist_3)
    @curator.add_artist(artist_3)

    assert_equal ["Diane Arbus"], @curator.artists_with_multiple_photographs

    photo_5 = {
         id: "1",
         name: "Seville",
         artist_id: "1",
         year: "1933"
    }

    photo_5 = Photograph.new(photo_5)
    @curator.add_photograph(photo_5)

    assert_equal ["Henri Cartier-Bresson", "Diane Arbus"], @curator.artists_with_multiple_photographs
  end

  def test_it_can_get_photographs_taken_by_artist_by_country
    photo_1 = Photograph.new(@photo_1)
    @curator.add_photograph(photo_1)
    photo_2 = Photograph.new(@photo_2)
    @curator.add_photograph(photo_2)
    photo_3 = Photograph.new(@photo_3)
    @curator.add_photograph(photo_3)
    photo_4 = Photograph.new(@photo_4)
    @curator.add_photograph(photo_4)

    artist_1 = Artist.new(@artist_1)
    @curator.add_artist(artist_1)
    artist_2 = Artist.new(@artist_2)
    @curator.add_artist(artist_2)
    artist_3 = Artist.new(@artist_3)
    @curator.add_artist(artist_3)

    assert_equal [photo_2, photo_3, photo_4], @curator.photographs_taken_by_artist_from("United States")
    assert_equal [], @curator.photographs_taken_by_artist_from("Argentina")
  end
end
