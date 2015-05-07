require 's-3po/events'
require 's-3po/generator'
require 's-3po/parser'


module S3PO

  # Parse Slack event into an S3PO Event object.
  # @param event [String] event from Slack in JSON string
  # @param opts [Hash] options
  # @return [Object] an S3PO::Event object
  def self.parse_event(event, opts = {})
    return Parser.parse_event(event, opts)
  end

  # Generate JSON message to send to Slack.
  # @param message [Hash] message event object
  # @param block [&block] provide a block to configure the message
  # @return [String] JSON ready to send to Slack
  def self.generate_message(message = {})
    if block_given?
      message = Message.new(message)
      yield message
    end
    return Generator.generate_message(message)
  end

  # Generate JSON ping to send to Slack.
  # @return [String] JSON ready to send to Slack
  def self.generate_ping
    return Generator.generate_ping()
  end

end
