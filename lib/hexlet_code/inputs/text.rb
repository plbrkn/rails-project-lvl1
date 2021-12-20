# frozen_string_literal: true

module HexletCode
  module Inputs
    class Text < BaseInput
      def build_input
        Tag.build('textarea', name: name, **atrrs) { value }
      end
    end
  end
end
