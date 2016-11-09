require 'test_helper'

class ListTest < Minitest::Test

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

  # Fake test
  def test_list
    resp = nil
    assert_nothing_raised do
      resp = ComicVine::API.get_list(:issues, limit: 5)
    end

    refute_nil resp
    assert_kind_of ComicVine::ResourceList, resp
    assert_equal 5, resp.count

    %w(total_count page_count offset limit).each do |m|
      assert_respond_to resp, m, 'testing ComicVine::ResourceList responds to: '+m
    end

    assert_kind_of ComicVine::Resource, resp.first
    assert_kind_of ComicVine::Resource, resp.last
    refute_equal resp.first.id, resp.last.id
    refute_same resp.first, resp.last
    assert_equal 5, resp.next_page.count
    assert_equal 5, resp.prev_page.count
  end
end