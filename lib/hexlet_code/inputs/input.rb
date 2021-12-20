# frozen_string_literal: true

module HexletCode
  module Inputs
    class Input < BaseInput
      def build_input
        Tag.build('input', name: name, type: 'text', value: value, **atrrs)
      end
    end
  end
end
