# EnumFor

Alternative to ActiveRecord::Enum for API use.

### Build

[![Travis CI](https://img.shields.io/travis/joel/enum_for.svg?branch=master)](https://travis-ci.org/joel/enum_for)

### Maintainability

![Maintenance](https://img.shields.io/maintenance/yes/2019.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/51aa08d8908ab501d537/maintainability)](https://codeclimate.com/github/joel/enum_for/maintainability)

### Code Quality 

[![Code Climate coverage](https://img.shields.io/codeclimate/coverage/joel/enum_for.svg)](https://codeclimate.com/github/joel/enum_for)
[![Coverage Status](https://coveralls.io/repos/github/joel/enum_for/badge.svg?branch=master)](https://coveralls.io/github/joel/enum_for?branch=master)
[![Code Climate issues](https://img.shields.io/codeclimate/issues/joel/enum_for.svg)](https://codeclimate.com/github/joel/enum_for/issues)
[![Code Climate maintainability](https://img.shields.io/codeclimate/maintainability/joel/enum_for.svg)](https://codeclimate.com/github/joel/enum_for/progress/maintainability)
[![Code Climate maintainability (percentage)](https://img.shields.io/codeclimate/maintainability-percentage/joel/enum_for.svg)](https://codeclimate.com/github/joel/enum_for/code)
[![Code Climate technical debt](https://img.shields.io/codeclimate/tech-debt/joel/enum_for.svg)](https://codeclimate.com/github/joel/enum_for/trends/technical_debt)

### Size 

![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/joel/enum_for.svg)
![GitHub repo size in bytes](https://img.shields.io/github/repo-size/joel/enum_for.svg)

### Usage 

![Gem](https://img.shields.io/gem/dv/enum_for/0.1.0.svg)
![Gem](https://img.shields.io/gem/v/enum_for.svg)
  
### Activity

![GitHub All Releases](https://img.shields.io/github/downloads/joel/enum_for/total.svg)
![GitHub last commit (master)](https://img.shields.io/github/last-commit/joel/enum_for/master.svg)
![GitHub Release Date](https://img.shields.io/github/release-date/joel/enum_for.svg)

### Documentation 
  
[![Inline docs](http://inch-ci.org/github/joel/enum_for.svg?branch=master)](http://inch-ci.org/github/joel/enum_for)
[![License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square)](http://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/gem/v/vcr.svg?style=flat-square)](https://rubygems.org/gems/enum_for)

### Security 

[![Libraries.io dependency status for latest release](https://img.shields.io/librariesio/release/joel/enum_for.svg)](https://libraries.io/github/joel/enum_for)

There are several concerns when using AR Enum with API, when you receive a payload it is hard to handle a proper error message.

```ruby
class Conversation < ActiveRecord::Base
  enum status: [ :draft, :active, :archived ]
end
```

```curl
curl -X POST \
  {{domain}}/api/v1/conversations \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -d '{
    "conversation": {
      "title": "Relativity theory",
      "status": "unactive"
    }'
```

```ruby
conversation = Conversation.new
conversation.status = "unactive"
=> ArgumentError ('unactive' is not a valid status)
```

instead with `EnumFor`

```ruby
class Conversation < ActiveRecord::Base
  extend EnumFor
  enum_for status: { draft: 0, active: 1, archived: 2 }
  validates :status, inclusion: statuses.keys
end
```

```curl
curl -X POST \
  {{domain}}/api/v1/conversations \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -d '{
    "conversation": {
      "title": "Relativity theory",
      "status": "unactive"
    }'
```

```ruby
conversation = Conversation.new
conversation.status = "unactive"
conversation.valid?
=> false 
conversation.errors.messages
=> { status: [ 'is not included in the list' ] }
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'enum_for'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install enum_for

## Usage

You need to extend the AR class you want to use it:

```ruby
class Conversation < ActiveRecord::Base
  extend EnumFor
  enum_for status: { draft: 0, active: 1, archived: 2 }
  validates :status, inclusion: statuses.keys
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/enum_for. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the EnumFor project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/enum_for/blob/master/CODE_OF_CONDUCT.md).
