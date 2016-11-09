require 'test_helper'

# noinspection RubyClassVariableUsageInspection
class ApiTest < Minitest::Test

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

  def test_initalize
    #assert defined? @@client, 'Verify client class was initalized'
  end

  def test_get_api_version
    assert_equal ComicVine::API.get_api_version, '1.0', 'Verify ComicVine API is at 1.0'
  end

  def test_search
    resp = nil
    assert_nothing_raised do
      resp = ComicVine::API.search(:volume, 'Avengers ', limit: 5)
    end

    refute_nil resp
    assert_kind_of ComicVine::SearchResults, resp
    assert_equal 5, resp.count
  end

  def test_types
    refute_nil ComicVine::API.types
    assert_equal 'issues', ComicVine::API.find_list(:issues)['list_resource_name']
    assert_equal 'issue', ComicVine::API.find_detail(:issue)['detail_resource_name']
    assert_equal 4000, ComicVine::API.find_detail(:issue)['id']
  end

  def test_get_list
    resp = ComicVine::API.get_list(:volumes, limit: 5)
    assert_kind_of ComicVine::ResourceList, resp
    assert_equal 5, resp.count
  end

  def test_get_details
    resp = ComicVine::API.get_details(:issue, '371103')
    assert_kind_of ComicVine::Resource, resp
    assert_equal 371103, resp.id
  end

  def test_get_details_by_url
    resp = ComicVine::API.get_details_by_url('http://comicvine.gamespot.com/api/issue/4000-371103')
    assert_kind_of ComicVine::Resource, resp
    assert_equal 371103, resp.id
  end

  def test_error
    assert_raises ComicVine::API::ResourceNotSupportedError do
      ComicVine::API.get_list(:fail)
    end

    assert_raises ComicVine::API::ComicVineAPIError do
      puts ComicVine::API.get_details_by_url('http://comicvine.gamespot.com/api/issuesx/371103')
    end

    assert_raises ComicVine::API::ComicVineAPIError do
      puts ComicVine::API.get_details_by_url('http://comicvine.gamespot.com/api/issue/371103')
    end

  end
end
