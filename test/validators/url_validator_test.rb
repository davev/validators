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
    valid_urls = %w(
      http://a.com
      http://www.a.com
      https://www.a.longtld
      http://a.b
      http://a.b.c.d.e
      http://www.a.com/
      http://www.a.com/b
      http://www.a.com/b/c
      http://www.a.com/b/c.html
      https://a.com
      https://www.a.com
      https://www.a.com/b
    )

    valid_urls.each do |url|
      @foo.url = url
      assert @foo.valid?, "expected #{url} to be valid"
    end
  end

  test "invalid url formats" do
    invalid_urls = %w(
      a
      a.com
      www.a.com
      //a.com
      //www.a.com
      //www
      //www.
      //www.a
      http://www
      http://www.
      http//a.com
      https://www
      https://www.
      https//a.b
    )

    invalid_urls.each do |url|
      @foo.url = url
      refute @foo.valid?, "expected #{url} to be invalid"
    end
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
