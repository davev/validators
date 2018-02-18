require "test_helper"

class EmailTest < ActiveSupport::TestCase

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

    puts @foo.errors.inspect
  end

end
