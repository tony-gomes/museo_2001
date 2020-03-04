require_relative 'test_helper'
require './lib/curator'
require './lib/artist'
require './lib/photograph'

class CuratorTest < MiniTest::Test
  def setup
    @curator = Curator.new
  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_it_starts_with_no_photographs
    assert_equal [], @curator.photographs
  end

  def test_it_can_add_photographs
    photo_1_attributes = {
         id: "1",
         name: "Rue Mouffetard, Paris (Boy with Bottles)",
         artist_id: "1",
         year: "1954"
    }

    photo_1 = Photograph.new(photo_1_attributes)
    @curator.add_photograph(photo_1)

    assert_equal [photo_1], @curator.photographs

    photo_2_attributes = {
         id: "2",
         name: "Moonrise, Hernandez",
         artist_id: "2",
         year: "1941"
    }

    photo_2 = Photograph.new(photo_2_attributes)
    @curator.add_photograph(photo_2)

    assert_equal [photo_1, photo_2], @curator.photographs
  end

  def test_it_starts_with_no_artists
    assert_equal [], @curator.artists
  end

  def test_it_can_add_artists
    artist_1_attributes = {
        id: "1",
        name: "Henri Cartier-Bresson",
        born: "1908",
        died: "2004",
        country: "France"
    }

    artist_1 = Artist.new(artist_1_attributes)
    @curator.add_artist(artist_1)

    assert_equal [artist_1], @curator.artists

    artist_2_attributes = {
        id: "2",
        name: "Ansel Adams",
        born: "1902",
        died: "1984",
        country: "United States"
    }

    artist_2 = Artist.new(artist_2_attributes)
    @curator.add_artist(artist_2)

    assert_equal [artist_1, artist_2], @curator.artists
  end

  def test_it_can_find_artist_by_id
    artist_1_attributes = {
        id: "1",
        name: "Henri Cartier-Bresson",
        born: "1908",
        died: "2004",
        country: "France"
    }

    artist_1 = Artist.new(artist_1_attributes)
    @curator.add_artist(artist_1)

    artist_2_attributes = {
        id: "2",
        name: "Ansel Adams",
        born: "1902",
        died: "1984",
        country: "United States"
    }

    artist_2 = Artist.new(artist_2_attributes)
    @curator.add_artist(artist_2)

    assert_equal artist_1, @curator.find_artist_by_id("1")
  end
end
