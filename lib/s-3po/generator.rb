require 'json'


module S3PO

  class Generator

    def self.generate_ping(id = nil)
      @id ||= 0
      msg = {type: 'ping'}
      msg[:id] = id ? id : @id
      @id += 1 unless id
      return JSON.fast_generate(msg)
    end

    def self.generate_message(message, id = nil)
      @id ||= 0
      obj = message.object
      msg = {type: 'message', channel: obj[:channel], text: obj[:text]}
      msg[:id] = id ? id : @id
      @id += 1 unless id
      return JSON.fast_generate(msg)
    end

    def self.text_from_plain(plain)
      text = String.new(plain)
      # escape
      text.gsub!('&', '&amp;')
      text.gsub!('<', '&lt;')
      text.gsub!('>', '&gt;')
      # add brackets to mentions
      text.gsub!(/(@[a-z0-9][a-z0-9.\-_]*)/, '<\1>')
      text.gsub!(/(@U[A-Z0-9]+)/, '<\1>')
      # add brackets to channels
      text.gsub!(/(#[a-z0-9\-_]+)/, '<\1>')
      text.gsub!(/(#C[A-Z0-9]+)/, '<\1>')
      # convert commands
      text.gsub!(/<@(everyone|channel|group)>/, '<!\1>')
      return text
    end

  end

end
