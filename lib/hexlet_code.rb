# frozen_string_literal: true

require_relative "hexlet_code/version"
require_relative "hexlet_code/tag"
require_relative "hexlet_code/form"

module HexletCode
  class Error < StandardError; end

  def self.form_for(obj, url: "#")
    form = Form.new(obj)
    yield form
    Tag.build("form", action: url, method: "post") { "\n#{form}\n" }
  end
end
