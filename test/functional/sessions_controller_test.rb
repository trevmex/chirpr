require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @user = User.create(:name => "Super Tester", :password => "12345", :password_confirmation => "12345")
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should log in a user" do
    post :create, :name => "Super Tester", :password => "12345"
    assert_equal(session[:user_id], @user.id)
    assert_equal(flash[:notice], "Logged in!")
    assert_redirected_to root_url
  end

  test "should log out a user" do
    post :create, :name => "Super Tester", :password => "12345"
    delete :destroy
    assert_nil(session[:user_id])
    assert_equal(flash[:notice], "Logged out!")
    assert_redirected_to root_url
  end
end
