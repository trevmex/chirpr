require 'test_helper'
require 'bcrypt'

class UserTest < ActiveSupport::TestCase
  test "a password is encrypted" do
    user = User.new(:password => "12345")

    user.encrypt_password

    assert_not_nil(user.password_salt)
    assert_not_nil(user.password_hash)
    assert_equal(user.password_hash, BCrypt::Engine.hash_secret(user.password, user.password_salt))
  end

  test "a user can authenticate" do
    user = User.create(:name => "Test guy", :password => "54321", :password_confirmation => "54321")

    assert_not_nil(user)
    assert_equal(User.authenticate("Test guy", "54321"), user)
  end

  test "a non-existance user cannot authenticate" do
    assert_nil(User.authenticate("Bobo deosn't exist", "12345"))
  end

  test "a user cannot authenticate with a bad password" do
    user = User.create(:name => "Test guy 2", :password => "54321", :password_confirmation => "54321")

    assert_not_nil(user)
    assert_nil(User.authenticate("Test guy 2", "bad password"))
  end
end
