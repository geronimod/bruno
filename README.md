# Bruno

Street + Housenumber mapping to OSM data. This is a WIP, don't fork it until it reach version 1.x.

## Installation

Add this line to your application's Gemfile:

    gem 'bruno'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bruno

## Usage

    bruno_finder = Bruno::Finder.new osm_file, cache: true

    # find a way
    response = bruno_finder.find "San Martin"
    response.success?
    response.ways
    response.way_ids
    response.way_nodes

    # find by housenumber
    response = bruno_finder.find "San Martin", 440
    response.node_ids
    response.closest_node

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

[See it](LICENSE.txt)