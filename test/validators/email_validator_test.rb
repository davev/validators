require "test_helper"

class EmailValidatorTest < ActiveSupport::TestCase

  class Foo
    attr_accessor :email
    include ActiveModel::Validations

    validates :email, email: true
  end

  setup do
    @foo = Foo.new
  end


  test "valid email formats" do
    @foo.email = "a@a.com"
    assert @foo.valid?

    @foo.email = "abc@def.longtld"
    assert @foo.valid?

    @foo.email = "a@b.c"
    assert @foo.valid?

    @foo.email = "a.b@c.d"
    assert @foo.valid?

    @foo.email = "a.b@c.d.e"
    assert @foo.valid?
  end

  test "invalid email formats" do
    @foo.email = "a"
    refute @foo.valid?

    @foo.email = "a@"
    refute @foo.valid?

    @foo.email = "a@a"
    refute @foo.valid?

    @foo.email = "a@a."
    refute @foo.valid?

    @foo.email = "@a"
    refute @foo.valid?

    @foo.email = "@a."
    refute @foo.valid?

    @foo.email = "@a.b"
    refute @foo.valid?

    @foo.email = "a.b@c."
    refute @foo.valid?
  end

  test "default error message" do
    @foo.email = "a"
    refute @foo.valid?
    assert_includes @foo.errors.messages[:email], EmailValidator::DEFAULT_ERROR_MESSAGE
  end

  test "custom error message" do
    CUSTOM_MESSAGE = "custom error message".freeze

    class Bar
      attr_accessor :email
      include ActiveModel::Validations

      validates :email, email: { message: CUSTOM_MESSAGE }
    end

    @bar = Bar.new
    @bar.email = "a"
    refute @bar.valid?
    assert_includes @bar.errors.messages[:email], CUSTOM_MESSAGE
  end

end
