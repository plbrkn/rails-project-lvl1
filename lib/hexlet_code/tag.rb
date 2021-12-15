# frozen_string_literal: true

module HexletCode
  # Tag builder
  class Tag
    SINGLE_TAGS = %w[br input img].freeze

    def self.build(tag, attrs = {})
      html_attrs = attrs.map { |(key, value)| " #{key}='#{value}'" }.join
      if SINGLE_TAGS.include?(tag)
        "<#{tag}#{html_attrs}>"
      else
        "<#{tag}#{html_attrs}>#{block_given? ? yield : ''}</#{tag}>"
      end
    end
  end
end
