# Uaeds

## About UA EDS

UA EDS is a gem that provides a wrapper to basic EDS DSML/JSON endpoint functionality as provided by the UA.

The code isn't the most beautiful and test coverage is mediocre, and it probably has one or 2 gotchas, but it works.

The tests mostly cover integration, not line by line units. It is perfectly possible to mock documents for unit testing by monkey patching in a method to set the local document to a particular value, but it hasn't been done. Consider it a todo.


## Usage

You have a choice between `EdsDSML` and `EdsJSON`. The difference is that DSML requires access to the DSML API endpoint and abstracts an XML document to find properties, while JSON uses a JSON-providing endpoint and abstracts JSON parsed into a hash.

Either way, you need to provide an endpoint, EDS user, and access key for library to use.
```ruby
eds = EdsDSML.new("https://<endpoint>", <user>, <key>)
person = eds.person_by_netid(<netid>)
person.uaid
person.uid
person.name
# ...

```
Whether you choose JSON or DSML endpoints, it works pretty much the same way. 

To get an unmapped attribute, use `.lookup_value('camelCaseValue')`, which should return `nil` for unvalued items.

If a document isn't found, rather than getting `nil` or an error back, all values on the retreived object should be `nil`. (Less than ideal.)

If using the JSON flavor, it's possible that a poorly formed request will grab multiple results and trigger an `ArgumentError: Argument is not a hash`. (Once again, currently less than ideal.)


## Testing

Currently, `bundle exec rspec spec` is the way to run tests. (No rake job yet.) It wil prompt for EDS user name, EDS key, DSML endpoint, JSON endpoint, and a 'NetID' for testing purposes.

If you feel lazy, it should work if you create a file `test_creds.in` formatted like:
```
<user>
<password>
<DSML endpoint>
<JSON endpoint>
<Test NetID>
```
and run `bundle exec rspec spec < test_creds.in`, though you might get some `stty: standard input: Inappropriate ioctl for device` messages.


## Installation

Add this line to your application's Gemfile:

    gem 'uaeds'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install uaeds

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
