require 'test_helper'
require 'bcrypt'

class UserTest < ActiveSupport::TestCase
  setup do
    @new_user = User.new({"name"=>"New Tester", "description"=>"testing"})
    @user = User.create({"name"=>"Tester", "password_confirmation"=>"12345", "description"=>"testing", "password"=>"12345"})
  end

  test "that authentication works for an existing user" do
    assert_not_nil(User.authenticate("Tester", "12345"))
  end

  test "that authentication fails for an existing user and bad password" do
    assert_nil(User.authenticate("Tester", "BAD PASSWORD"))
  end

  test "that authentication fails for a non-existant user" do
    assert_nil(User.authenticate("Bob", "passoword"))
  end

  test "that a password is encrypted correctly" do
    @new_user.password = "12345"
    @new_user.encrypt_password
    assert_equal(@new_user.password_hash, BCrypt::Engine.hash_secret("12345", @new_user.password_salt))
  end

  test "that nothing happens if no password is set" do
    assert_nil(@new_user.encrypt_password)
  end
end
