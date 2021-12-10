# frozen_string_literal: true

require "test_helper"
require_relative "../lib/hexlet_code"

class HexletCodeTest < Minitest::Test
  def test_tag
    assert(HexletCode::Tag.build("br") == "<br>")
    assert(HexletCode::Tag.build("img", src: "path/to/image") == "<img src='path/to/image'>")
    assert(HexletCode::Tag.build("input", type: "submit", value: "Save") == "<input type='submit' value='Save'>")
    assert(HexletCode::Tag.build("label") { "Email" } == "<label>Email</label>")
    assert(HexletCode::Tag.build("label", for: "email") { "Email" } == "<label for='email'>Email</label>")
    assert(HexletCode::Tag.build("div") == "<div></div>")
  end

  def test_form_for
    assert(HexletCode.form_for("/user") == "<form action='/user' method='post'></form>")
  end
end
