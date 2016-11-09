# Comicvine

A ruby gem to interface with the [ComicVine API](http://comicvine.gamespot.com/api/). 

Some code was built off of work by [Patrick Sharp](https://github.com/Jakanapes), you can find it [here](https://github.com/Jakanapes/ComicVine)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'comicvine'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install comicvine

Then set a environmental variable named `CV_API_KEY` to your ComicVine API key **(optional)**

    $ export CV_API_KEY=18357f40df87fb4a4aa6bbbb27cd8ad1deb08d3e

## Usage

If you did not set the env variable `CV_API_KEY` then you need to set the class `api_key` before using. If you did set the env variable you do not need to set this.

```ruby
resp = ComicVine::API.api_key = '18357f40df87fb4a4aa6bbbb27cd8ad1deb08d3e'
```

Gather response from a url:

```ruby
resp = ComicVine::API.get_details_by_url('http://comicvine.gamespot.com/api/issue/4000-371103')
```

You can also fetch lists of resources while passing API options: (see [ComicVine API Docs](http://comicvine.gamespot.com/api/documentation) for optional values)

```ruby
vol_list = ComicVine::API.get_list(:volumes, limit: 50)
```

You can fetch a more specific result by id:

```ruby
issue = ComicVine::API.get_details(:issue, '371103')
```

Performing a search:

```ruby
results = ComicVine::API.search(:volume, 'Avengers ', limit: 5)

# Go to next 5 results
results.next_page

# Go to last 5 results
results.prev_page
```

Create also create an `ComicVine::API` instance using your API key:

```ruby
api = ComicVine::API.new('18357f40df87fb4a4aa6bbbb27cd8ad1deb08d3e')
```

You can gather more detailed API information at http://rubydoc.info/gems/comicvine

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `gem install comicvine`. Or you can download it from https://rubygems.org/gems/comicvine

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kalinon/ruby-comicvine-api.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

