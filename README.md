# Bruno

Street + Housenumber mapping to OSM data

## Installation

Add this line to your application's Gemfile:

    gem 'bruno'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bruno

## Usage

    finder = Bruno::Finder.new spec_osm_file

    # find a way
    response = finder.find "San Martin"
    response.success?
    response.ways
    response.way_ids
    response.way_nodes

    # find by housenumber
    response = finder.find "San Martin", 440
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