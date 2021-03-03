require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should save with an email address, username and password" do
    user = User.new
    user.email_address = "test@test.com"
    user.username = "test"
    user.password = "123456"
    assert user.save, "user needs an email address, username and password"
  end
end
