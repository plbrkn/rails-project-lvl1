# frozen_string_literal: true

module HexletCode
  module Inputs
    class BaseInput
      attr_reader :name, :value, :atrrs

      def initialize(value, name, **atrrs)
        @name = name
        @value = value
        @atrrs = atrrs
      end

      def build
        out = [Tag.build('label', for: name) { name.capitalize }]
        out << build_input
      end
    end
  end
end
