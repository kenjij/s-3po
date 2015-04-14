module S3PO

  # Base event class; a generic event class should only come from Slack.
  class Event

    attr_reader :object
    attr_reader :options

    def initialize(event = {}, opts = {})
      fail 'Must be a Hash.' unless event.class == Hash
      @object = event
      @options = opts
    end

    # @return [Symbol]
    def type
      return :response unless object[:ok].nil?
      return object[:type].to_sym if object[:type]
      return nil
    end

    # Is it a message event?
    # @return [Boolean]
    def is_message?
      return !type.nil? && type == :message
    end

    # @return [Symbol]
    def subtype
      return object[:subtype].to_sym if object[:subtype]
      return nil
    end

    # Is it a simple message event; a straight forward text message without a subtype?
    # @return [Boolean]
    def is_simplemessage?
      is_message? && subtype.nil?
    end

    def user
      object[:user]
    end

    def channel
      object[:channel]
    end

    def channel=(string)
      fail 'Must be a String.' unless string.class == String
      fail 'Invalid channel' unless /[CD][0-9A-Z]+/ =~ string
      object[:channel] = string
    end

    def ts
      object[:ts]
    end

  end


  # Message Event class comes from Slack, or you would create one to send a message.
  class Message < Event

    def text
      object[:text]
    end

    def text=(string)
      fail 'Must be a String.' unless string.class == String
      object[:text] = string
      @plain = nil
    end

    def plain
      @plain ||= Parser.plain_from_text(text)
    end

    def plain=(string)
      fail 'Must be a String.' unless string.class == String
      @plain = string
      object[:text] = Generator.text_from_plain(@plain)
    end

    def mentions
      @mentions ||= Parser.mentions_from_text(text)
    end

    # Is the message directed to me; prefixed with bot username?
    # @return [Boolean]
    def is_instruction?
      return plain.start_with?("@#{options[:botid]}") if options[:botid]
      return false
    end

    # Break up the message text into an Arrary per word when prefixed with bot username; e.g., "@bot echo hello"
    # @return [Array] excluding the prefixed bot username
    def instruction
      return nil unless is_instruction?
      @instruction ||= Parser.instruction_from_plain(plain)
    end

  end

  class Response < Event

    def ok
      object[:ok]
    end

    def ok?
      ok
    end

  end

end
