# frozen_string_literal: true

module HexletCode
  # Form builder
  class Form
    attr_reader :obj, :output

    def initialize(obj)
      @obj = obj
      @output = []
    end

    def input(name, as: nil)
      output << make_input(name, as: as)
    end

    def textarea(name, value)
      Tag.build("textarea", cols: "20", rows: "40", name: name) { value }
    end

    def make_input(name, as: nil)
      value = obj.public_send(name)
      case as
      when :text
        textarea(name, value)
      else
        Tag.build("input", name: name, type: "text", value: value)
      end
    end

    def to_s
      output.join
    end
  end
end
