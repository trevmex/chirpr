require 'test_helper'

class StatusesControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @status = statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statuses)
  end

  test "should get edit" do
    get :edit, :id => @status.to_param
    assert_response :success
    assert_not_nil assigns(:status)
  end

  test "should show user" do
    get :show, :id => @status.to_param
    assert_response :success
    assert_not_nil assigns(:status)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:status)
  end

  test "should create status" do
    assert_difference('Status.count') do
      post :create, :user_id => @user.id, :status => {"description" => "test status"}
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should update status" do
    put :update, :id => @status.to_param, :status => @status.attributes
    assert_redirected_to status_path(assigns(:status))
  end

  test "should destroy status" do
    assert_difference('Status.count', -1) do
      delete :destroy, :id => @status.to_param
    end

    assert_redirected_to statuses_path
  end
end
