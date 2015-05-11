# S-3PO

[![Gem Version](https://badge.fury.io/rb/s-3po.svg)](http://badge.fury.io/rb/s-3po) [![security](https://hakiri.io/github/kenjij/s-3po/master.svg)](https://hakiri.io/github/kenjij/s-3po/master) [![Code Climate](https://codeclimate.com/github/kenjij/s-3po/badges/gpa.svg)](https://codeclimate.com/github/kenjij/s-3po) [![Dependency Status](https://gemnasium.com/kenjij/s-3po.svg)](https://gemnasium.com/kenjij/s-3po)

A protocol droid made by [Cybot Galactica](http://starwars.wikia.com/wiki/Cybot_Galactica) for [Slack](https://slack.com).

This gem parses, generates, and manupilates various Slack events and messages.

## Requirements

- Ruby 2.0.0 <=

## Usage

If you're creating integrations or bots for Slack, this may come useful. Install:

```
$ gem install s-3po
```

Then use:

```ruby
require 's-3po'
```

Your bot would connect to Slack via [RTM API](https://api.slack.com/rtm). Then process events like this.

```ruby
event = S3PO.parse_event(data_from_slack, {botid: bot_id})
puts "#{event.type} : #{event.subtype}"
puts event.plain if event.is_simplemessage?
# => "@U123ABC: hello you!"
```

Generate a message to send to Slack.

```ruby
json = S3PO.generate_message do |reply|
  reply.channel = 'CABC123'
  reply.plain = "@channel: what's up, ya all?"
end
puts json
# => {"type":"message","channel":"CABC123","text":"<!channel>: what's up, ya all?","id":0}
```

See [YARD Doc](http://www.rubydoc.info/gems/s-3po) for more info.

## What's Next

- Provide feedback
- Expect more updates
- Random anniversary on May 4th
