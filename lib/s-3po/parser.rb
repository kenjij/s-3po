require 'json'


module S3PO

  class Parser

    def self.parse_event(event, opts = {})
      obj = JSON.parse(event, {symbolize_names: true})
      return Response.new(obj, opts) if obj[:type].nil?
      return Message.new(obj, opts) if obj[:type] == 'message'
      return Event.new(obj, opts)
    end

    def self.mentions_from_text(text)
      mentions = []
      text.scan(/<@([^>|]*)[^>]*>/) { |m| mentions << m[0]}
      return mentions
    end

    def self.plain_from_text(text)
      # copy
      plain = String.new(text)
      # remove labels within brackets
      plain.gsub!(/<([^>|]*)[^>]*>/, '<\1>')
      # process commands
      plain.gsub!(/<!(everyone|channel|group)>/, '<@\1>')
      plain.gsub!(/<!(.*?)>/, '<\1>')
      # remove brackets
      plain.gsub!(/<(.*?)>/, '\1')
      # unescape
      plain.gsub!('&gt;', '>')
      plain.gsub!('&lt;', '<')
      plain.gsub!('&amp;', '&')
      return plain
    end

    def self.instruction_from_plain(plain, botid)
      a = plain.split()
      if a[0] && a[0].start_with?("@#{botid}")
        prefix = a.shift
      end
      return nil if a.empty?
      return a
    end

  end

end
