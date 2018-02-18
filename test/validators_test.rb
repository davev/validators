require "test_helper"

class ValidatorsTest < ActiveSupport::TestCase
  test "it has a version number" do
    refute_nil ::Validators::VERSION
  end
end
