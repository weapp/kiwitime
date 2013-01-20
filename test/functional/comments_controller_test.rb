require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @project/task = project/tasks(:one)
    @comment = comments(:one)
  end

  test "should get index" do
    get :index, :project/task_id => @project/task
    assert_response :success
    assert_not_nil assigns(:comments)
  end

  test "should get new" do
    get :new, :project/task_id => @project/task
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, :project/task_id => @project/task, :comment => @comment.attributes
    end

    assert_redirected_to project/task_comment_path(@project/task, assigns(:comment))
  end

  test "should show comment" do
    get :show, :project/task_id => @project/task, :id => @comment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :project/task_id => @project/task, :id => @comment.to_param
    assert_response :success
  end

  test "should update comment" do
    put :update, :project/task_id => @project/task, :id => @comment.to_param, :comment => @comment.attributes
    assert_redirected_to project/task_comment_path(@project/task, assigns(:comment))
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, :project/task_id => @project/task, :id => @comment.to_param
    end

    assert_redirected_to project/task_comments_path(@project/task)
  end
end
