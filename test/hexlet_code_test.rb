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
    struct_user = Struct.new(:name, :job, :gender, keyword_init: true)
    user = struct_user.new name: "rob", job: "hexlet", gender: "m"

    html = HexletCode.form_for user do |f|
      f.input :name
      f.input :job, as: :text, rows: 50, cols: 50
      f.submit
    end

    assert(html == "<form action='#' method='post'>\n <label for='name'>Name</label>\n <input name='name' type='text' value='rob'>\n <label for='job'>Job</label>\n <textarea cols='50' rows='50' name='job'>hexlet</textarea>\n <input name='commit' type='submit' value='Save'>\n</form>")
  end

  def test_form_for_not_attribut
    struct_user = Struct.new(:name, :job, :gender, keyword_init: true)
    user = struct_user.new name: "rob", job: "hexlet", gender: "m"

    exception = assert_raises StandardError do
      HexletCode.form_for user, url: "/users" do |f|
        f.input :name
        f.input :job, as: :text
        f.input :age
        f.submit
      end
    end

    assert_equal("undefined method `age' for #<struct name=\"rob\", job=\"hexlet\", gender=\"m\">", exception.message)
  end
end
