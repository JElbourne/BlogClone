require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @user = users(:unsubscribed)
    @post = posts(:one)
    @comment = comments(:one)
    @comment.user_id = @user.id
    @comment.post_id = @post.id
    @comment.save
    @request.env['HTTP_REFERER'] = 'http://test.host/'
  end

  test "should get index" do
    sign_in @user
    get :index
    assert_response :success
    assert_not_nil assigns(:comments)
  end

  test "should not get index if no user" do
    get :index
    assert_redirected_to new_user_session_path
  end
  
  test "should create comment" do
    sign_in @user
    assert_difference('Comment.count') do
      post :create, id: @post.id, comment: { body: @comment.body, post_id: @comment.post_id, user_id: @comment.user_id }
    end

    assert_redirected_to post_path(@comment.post_id)
  end

  test "should not create comment due to error" do
    sign_in @user
    assert_no_difference('Comment.count') do
      post :create, id: @post.id, comment: { body: " " }
    end

    assert_redirected_to post_path(@post)
  end

  test "should get edit" do
    sign_in @user
    get :edit, id: @comment
    assert_response :success
  end

  test "should not get edit if no user" do
    get :edit, id: @comment
    assert_redirected_to new_user_session_path
  end

  test "should update comment" do
    sign_in @user
    patch :update, id: @comment, comment: { body: @comment.body }
    assert_redirected_to post_path(@comment.post)
   end

  test "should not update comment due to error" do
    sign_in @user
    patch :update, id: @comment, comment: { body: " " }
    assert_template :edit
   end

  test "should destroy comment" do
    sign_in @user
    assert_difference('Comment.count', -1) do
      delete :destroy, id: @comment
    end

    assert_redirected_to root_path
  end
end
