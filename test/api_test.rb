require 'test_helper'

# noinspection RubyClassVariableUsageInspection
class ApiTest < Minitest::Test

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

  def test_initalize
    assert defined? @@client, 'Verify client class was initalized'
  end

  def test_get_api_version
    assert_equal @@client.get_api_version, '1.0', 'Verify ComicVine API is at 1.0'
  end

  def test_search
    resp = nil
    assert_nothing_raised do
      resp = @@client.search(:volume, 'Avengers ', limit: 5)
    end

    refute_nil resp
    assert_kind_of ComicVine::CVSearchList, resp
    assert_equal 5, resp.count
  end

  def test_types
    refute_nil @@client.types
    assert_equal 'issues', @@client.find_list(:issues)['list_resource_name']
    assert_equal 'issue', @@client.find_detail(:issue)['detail_resource_name']
    assert_equal 4000, @@client.find_detail(:issue)['id']
  end

  def test_get_list
    resp = @@client.get_list(:volumes, limit: 5)
    assert_kind_of ComicVine::CVObjectList, resp
    assert_equal 5, resp.count
  end

  def test_get_details
    resp = @@client.get_details(:issue, '371103')
    assert_kind_of ComicVine::CVObject, resp
    assert_equal 371103, resp.id
  end

  def test_get_details_by_url
    resp = @@client.get_details_by_url('http://comicvine.gamespot.com/api/issue/4000-371103')
    assert_kind_of ComicVine::CVObject, resp
    assert_equal 371103, resp.id
  end

  def test_error
    assert_raises ComicVine::API::ResourceNotSupportedError do
      @@client.get_list(:fail)
    end

    assert_raises ComicVine::API::ComicVineAPIError do
      puts @@client.get_details_by_url('http://comicvine.gamespot.com/api/issuesx/371103')
    end

    assert_raises ComicVine::API::ComicVineAPIError do
      puts @@client.get_details_by_url('http://comicvine.gamespot.com/api/issue/371103')
    end

  end
end
