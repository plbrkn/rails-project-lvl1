# frozen_string_literal: true

require_relative 'inputs/base_input'
require_relative 'inputs/input'
require_relative 'inputs/text'

module HexletCode
  # Form builder
  class Form
    attr_reader :obj, :output

    def initialize(obj)
      @obj = obj
      @output = []
    end

    def input(name, options = {})
      output << make_input(name, **options)
    end

    def submit(value = 'Save')
      output << Tag.build('input', name: 'commit', type: 'submit', value: value)
    end

    # rubocop:disable Naming/MethodParameterName
    def make_input(name, as: 'input', **atrrs)
      value = obj.public_send(name)

      Object.const_get("HexletCode::Inputs::#{as.to_s.capitalize}").new(value, name, **atrrs).build
    end
    # rubocop:enable Naming/MethodParameterName

    def to_s
      output.join("\n")
    end
  end
end
