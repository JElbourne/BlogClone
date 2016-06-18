require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:one)
    @request.env['HTTP_REFERER'] = 'http://test.host/posts'
  end

  test "should show post" do
    get :show, id: @post
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should not get new if user not Admin" do
    get :new
    assert_redirected_to posts_path
  end

  test "should get new" do
    admin = users(:admin)
    sign_in admin
    get :new
    assert_response :success
  end

  test "should create post" do
    admin = users(:admin)
    sign_in admin
    assert_difference('Post.count') do
      post :create, post: { body: @post.body, title: @post.title }
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should not create post if post has error" do
    admin = users(:admin)
    sign_in admin
    assert_no_difference('Post.count') do
      post :create, post: { body: @post.body }
    end

    assert_template :new
  end

  test "should not get edit without Admin" do
    get :edit, id: @post
    assert_redirected_to posts_path
  end

  test "should get edit" do
    admin = users(:admin)
    sign_in admin
    get :edit, id: @post
    assert_response :success
  end

  test "should update post" do
    admin = users(:admin)
    sign_in admin
    patch :update, id: @post, post: { body: @post.body, title: @post.title }
    assert_redirected_to post_path(assigns(:post))
  end

  test "should not update post if errors" do
    admin = users(:admin)
    sign_in admin
    patch :update, id: @post, post: { body: " " }
    assert_template :edit
  end

  test "should destroy post" do
    admin = users(:admin)
    sign_in admin
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_redirected_to posts_path
  end
end
