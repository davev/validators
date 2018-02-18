require "test_helper"

class UrlValidatorTest < ActiveSupport::TestCase

  class Foo
    attr_accessor :url
    include ActiveModel::Validations

    validates :url, url: true
  end

  setup do
    @foo = Foo.new
  end


  test "valid url formats" do
    @foo.url = "http://a.com"
    assert @foo.valid?

    @foo.url = "http://www.a.com"
    assert @foo.valid?

    @foo.url = "https://www.a.longtld"
    assert @foo.valid?

    @foo.url = "http://a.b"
    assert @foo.valid?

    @foo.url = "http://a.b.c.d.e"
    assert @foo.valid?
  end

  test "invalid url formats" do
    @foo.url = "a"
    refute @foo.valid?

    @foo.url = "a.com"
    refute @foo.valid?

    @foo.url = "www.a.com"
    refute @foo.valid?

    @foo.url = "//a.com"
    refute @foo.valid?

    @foo.url = "//www.a.com"
    refute @foo.valid?

    @foo.url = "//www."
    refute @foo.valid?

    @foo.url = "//www.a."
    refute @foo.valid?

    @foo.url = "http//www."
    refute @foo.valid?

    @foo.url = "http//www.a"
    refute @foo.valid?

    @foo.url = "http//www.a."
    refute @foo.valid?
  end

  test "default error message" do
    @foo.url = "a"
    refute @foo.valid?
    assert_includes @foo.errors.messages[:url], UrlValidator::DEFAULT_ERROR_MESSAGE
  end

  test "custom error message" do
    CUSTOM_MESSAGE = "custom error message".freeze

    class Bar
      attr_accessor :url
      include ActiveModel::Validations

      validates :url, url: { message: CUSTOM_MESSAGE }
    end

    @bar = Bar.new
    @bar.url = "a"
    refute @bar.valid?
    assert_includes @bar.errors.messages[:url], CUSTOM_MESSAGE
  end

end
