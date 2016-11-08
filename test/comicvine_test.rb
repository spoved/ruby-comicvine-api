require 'test_helper'
require 'json'

# noinspection RubyInstanceMethodNamingConvention
class ComicVineTest < Minitest::Test

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

  def test_that_it_has_a_version_number
    refute_nil ::ComicVine::VERSION
    refute_nil ::ComicVine::API_VERSION
  end

  def test_env
    refute_nil ENV['CV_API_KEY'], 'Environmental CV_API_KEY cannot be blank'
  end

end
