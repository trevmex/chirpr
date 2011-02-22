require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @user = User.create({"name"=>"Tester", "password_confirmation"=>"12345", "description"=>"testing", "password"=>"12345"})
  end

  test "should log in a user" do
    post :create, :name => "Tester", :password => "12345"
    assert_equal(session[:user_id], @user.id)
    assert_redirected_to root_url
    assert_equal(flash[:notice], "Logged in!")
  end

  test "should log out a user" do
    post :create, :name => "Tester", :password => "12345"
    assert_equal(session[:user_id], @user.id)
    delete :destroy
    assert_nil(session[:user_id])
    assert_redirected_to root_url
    assert_equal(flash[:notice], "Logged out!")
  end

  test "should get new" do
    get :new
    assert_response :success
  end
end
