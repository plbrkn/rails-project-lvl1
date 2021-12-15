# frozen_string_literal: true

require "spec_helper"

RSpec.describe HexletCode do
  describe "My test" do
    let(:struct) { Struct.new(:name, :job, :gender, keyword_init: true) }
    let(:user) { struct.new(name: "rob", job: "hexlet", gender: "m") }

    it "tag" do
      expect(HexletCode::Tag.build("br")).to have_tag("br")
      expect(HexletCode::Tag.build("img", src: "path/to/image")).to have_tag("img")
      expect(HexletCode::Tag.build("input", type: "submit", value: "Save")).to have_tag("input")
      expect(HexletCode::Tag.build("label")).to have_tag("label")
      expect(HexletCode::Tag.build("div")).to have_tag("div")
    end

    it "form_for" do
      html = HexletCode.form_for user do |f|
        f.input :name
        f.input :job, as: :text, rows: 50, cols: 50
        f.submit
      end

      expected_matcher = have_tag("form") do
        with_tag "label", with: { for: "name" }
        with_tag "input", with: { name: "name", type: "text" }
        with_tag "label", with: { for: "job" }
        with_tag "textarea", with: { name: "job", rows: 50, cols: 50 }
        with_tag "input", with: { type: "submit", value: "Save" }
      end

      expect(html).to expected_matcher
    end

    it "form_for_not_attribut" do
      exception = lambda do
        HexletCode.form_for user, url: "/users" do |f|
          f.input :name
          f.input :job, as: :text
          f.input :age
          f.submit
        end
      end

      expect(exception).to raise_error NoMethodError
    end
  end

  describe "Hexlet test" do
    let(:struct) { Struct.new(:name, :job, keyword_init: true) }
    let(:user) { struct.new(name: "rob", job: "hexlet") }

    it "new" do
      actual = HexletCode.form_for user, url: "#" do |f|
        f.input :name, class: "user-input"
        f.input :job
        f.submit
      end

      expected_matcher = have_tag("form") do
        with_tag "label", with: { for: "name" }
        with_tag "input", with: { value: user.name, name: "name", type: "text", class: "user-input" }
        with_tag "label", with: { for: "job" }
        with_tag "input", with: { type: "text", name: "job" }
        with_tag "input", with: { type: "submit", value: "Save" }
      end

      expect(actual).to expected_matcher
    end

    it "existed" do
      actual = HexletCode.form_for user, url: "#" do |f|
        f.input :name
        f.input :job, as: :text, rows: 50, cols: 50
        f.submit "Wow"
      end

      expected_matcher = have_tag("form") do
        with_tag "label", with: { for: "name" }
        with_tag "input", with: { name: "name", type: "text" }
        with_tag "label", with: { for: "job" }
        with_tag "textarea", with: { name: "job", rows: 50, cols: 50 }
        with_tag "input", with: { type: "submit", value: "Wow" }
      end

      expect(actual).to expected_matcher
    end

    it "send not exists user method" do
      actual = lambda do
        HexletCode.form_for user do |f|
          f.input :company
          f.submit "Boom!"
        end
      end

      expect(actual).to raise_error NoMethodError
    end
  end
end
