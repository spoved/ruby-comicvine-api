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

## Usage

Create an `ComicVine::API` instance using your API key:

```ruby
api = ComicVine::API.new('18357f40df87fb4a4aa6bbbb27cd8ad1deb08d3e')
```

Gather response from a url:

```ruby
resp = api.get_details_by_url("http://comicvine.gamespot.com/api/issue/4000-371103")
```

You can also fetch lists of resources while passing API options: (see [ComicVine API Docs](http://comicvine.gamespot.com/api/documentation) for optional values)

```ruby
vol_list = api.get_list(:volumes, limit: 50)
```

You can fetch a more specific result by id:

```ruby
issue = api.get_details(:issue, '371103')
```

Performing a search:

```ruby
results = api.search(:volume, 'Avengers ', limit: 5)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kalinon/ruby-comicvine-api.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

