# frozen_string_literal: true

module HexletCode
  autoload :Tag, 'hexlet_code/tag'

  # Form builder
  class Form
    attr_reader :obj, :output

    def initialize(obj)
      @obj = obj
      @output = []
    end

    def input(name, options = {})
      output << " #{Tag.build('label', for: name) { name.capitalize }}"
      output << " #{make_input(name, **options)}"
    end

    def textarea(name, value, cols = 20, rows = 40, **atrrs)
      Tag.build('textarea', cols: cols, rows: rows, name: name, **atrrs) { value }
    end

    def submit(value = 'Save')
      output << " #{Tag.build('input', name: 'commit', type: 'submit', value: value)}"
    end

    # rubocop:disable Naming/MethodParameterName
    def make_input(name, as: nil, **atrrs)
      value = obj.public_send(name)
      case as
      when :text
        textarea(name, value, **atrrs)
      else
        Tag.build('input', name: name, type: 'text', value: value, **atrrs)
      end
    end
    # rubocop:enable Naming/MethodParameterName

    def to_s
      output.join("\n")
    end
  end
end
