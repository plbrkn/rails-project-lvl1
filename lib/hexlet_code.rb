# frozen_string_literal: true

module HexletCode
  autoload :Form, 'hexlet_code/form'
  autoload :Tag, 'hexlet_code/tag'
  autoload :VERSION, 'hexlet_code/version'

  class Error < StandardError; end

  def self.form_for(obj, url: '#')
    form = Form.new(obj)
    yield form
    Tag.build('form', action: url, method: 'post') { "\n#{form}\n" }
  end
end
