# S-3PO

A protocol droid made by Cybot Galactica for Slack.

This gem parses, generates, and manupilates various Slack events and messages.

## Requirements

- Ruby 2.0.0 <=

## Usage

If you're creating integrations or bots for Slack, this may come useful. Install:

```
$ gem install subaru
```

Then use:

```ruby
require 's-3po'
```

Your bot would connect to Slack via [RTM API](https://api.slack.com/rtm). Then process events like this.

```ruby
event = S3PO.parse_event(data_from_slack)
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
# => "<!channel>: what's up, ya all?"
```

See [YARD Doc](http://www.rubydoc.info/github/kenjij/s-3po) for more info.

## What's Next

- Provide feedback
- Expect more updates
- Random anniversary at May 4th
