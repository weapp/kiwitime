require 'test_helper'

class SittingsControllerTest < ActionController::TestCase
  setup do
    @sitting = sittings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sittings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sitting" do
    assert_difference('Sitting.count') do
      post :create, sitting: { end: @sitting.end, start: @sitting.start, task_id: @sitting.task_id, user_id: @sitting.user_id }
    end

    assert_redirected_to sitting_path(assigns(:sitting))
  end

  test "should show sitting" do
    get :show, id: @sitting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sitting
    assert_response :success
  end

  test "should update sitting" do
    put :update, id: @sitting, sitting: { end: @sitting.end, start: @sitting.start, task_id: @sitting.task_id, user_id: @sitting.user_id }
    assert_redirected_to sitting_path(assigns(:sitting))
  end

  test "should destroy sitting" do
    assert_difference('Sitting.count', -1) do
      delete :destroy, id: @sitting
    end

    assert_redirected_to sittings_path
  end
end
