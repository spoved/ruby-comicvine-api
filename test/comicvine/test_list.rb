require 'test_helper'

class ListTest < Minitest::Test

  @@client = ComicVine::API.new(ENV['CV_API_KEY'])

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

  def test_search_results
    #resp = nil
    #assert_nothing_raised do
    #  resp = @@client.search(:volume, 'Avengers ', limit: 5)
    #end

    #refute_nil resp
    #assert_kind_of ComicVine::SearchResults, resp
    #assert_equal 5, resp.count
  end
end