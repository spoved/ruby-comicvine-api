require 'test_helper'
require 'json'

class ResourceTest < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.
  def teardown
    # Do nothing
  end

  def test_identify_type
    assert_equal :review, ComicVine::Resource.identify_type('http://comicvine.gamespot.com/api/review/1900-1224/')
    assert_equal :creator, ComicVine::Resource.identify_type('http://comicvine.gamespot.com/api/creator/4040-45065/')
    assert_equal :person, ComicVine::Resource.identify_type('http://comicvine.gamespot.com/api/person/4040-45065/')
    assert_equal :volume, ComicVine::Resource.identify_type('http://comicvine.gamespot.com/api/volume/4050-54428')
    assert_equal :issue, ComicVine::Resource.identify_type('comicvine.gamespot.com/api/issue/4000-371103')
  end

  def test_create_resource
    hash = JSON.parse('{"aliases":null,"api_detail_url":"http://comicvine.gamespot.com/api/issue/4000-6/","cover_date":"1952-10-01","date_added":"2008-06-06 11:10:16","date_last_updated":"2015-07-11 12:08:20","deck":null,"description":"<p>The horrors of:</p><p>- Lost race!</p><p>- The man germ!</p><p>- Man in the hood!</p><p>- The things!</p><p>-Stories behind the stars, featuring the legendary battle between Hercules, Hydra and Iolaus!</p><p>Plus, two page long prose-stories.</p>","has_staff_review":false,"id":6,"image":{"icon_url":"http://comicvine.gamespot.com/api/image/square_avatar/2645776-chamber_of_chills__13_cgc_8.5.jpg","medium_url":"http://comicvine.gamespot.com/api/image/scale_medium/2645776-chamber_of_chills__13_cgc_8.5.jpg","screen_url":"http://comicvine.gamespot.com/api/image/screen_medium/2645776-chamber_of_chills__13_cgc_8.5.jpg","small_url":"http://comicvine.gamespot.com/api/image/scale_small/2645776-chamber_of_chills__13_cgc_8.5.jpg","super_url":"http://comicvine.gamespot.com/api/image/scale_large/2645776-chamber_of_chills__13_cgc_8.5.jpg","thumb_url":"http://comicvine.gamespot.com/api/image/scale_avatar/2645776-chamber_of_chills__13_cgc_8.5.jpg","tiny_url":"http://comicvine.gamespot.com/api/image/square_mini/2645776-chamber_of_chills__13_cgc_8.5.jpg"},"issue_number":"13","name":"The Lost Race","site_detail_url":"http://comicvine.gamespot.com/chamber-of-chills-magazine-13-the-lost-race/4000-6/","store_date":null,"volume":{"api_detail_url":"http://comicvine.gamespot.com/api/volume/4050-1487/","id":1487,"name":"Chamber of Chills Magazine","site_detail_url":"http://comicvine.gamespot.com/chamber-of-chills-magazine/4050-1487/"}}')
    assert_kind_of Hash, hash
    type = ComicVine::Resource.identify_type(hash['api_detail_url'])
    assert_equal :issue, type

    assert_nothing_raised do
      obj = Object.class_eval('ComicVine::Resource::' + type.to_s.capitalize).new hash
      assert_kind_of ComicVine::Resource, obj
      assert_kind_of ComicVine::Resource::Issue, obj
    end
  end

end