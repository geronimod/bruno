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

bruno = Bruno.new street: "San Martin", housenumber: 460

bruno.osm_nodes

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
