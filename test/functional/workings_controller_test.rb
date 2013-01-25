require 'test_helper'

class WorkingsControllerTest < ActionController::TestCase
  setup do
    @working = workings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create working" do
    assert_difference('Working.count') do
      post :create, working: { day: @working.day, id_sprint: @working.id_sprint }
    end

    assert_redirected_to working_path(assigns(:working))
  end

  test "should show working" do
    get :show, id: @working
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @working
    assert_response :success
  end

  test "should update working" do
    put :update, id: @working, working: { day: @working.day, id_sprint: @working.id_sprint }
    assert_redirected_to working_path(assigns(:working))
  end

  test "should destroy working" do
    assert_difference('Working.count', -1) do
      delete :destroy, id: @working
    end

    assert_redirected_to workings_path
  end
end
