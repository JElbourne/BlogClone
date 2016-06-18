require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  setup do
    @user = users(:unsubscribed) 
    @post = posts(:one)
    @params = {
               body: "Test comment body",
               user_id: @user.id,
               post_id: @post.id
    }
  end

  test "can create a Comment" do
    comment = Comment.create(@params)
    assert comment.valid?
  end

  test "can not create a Comment if user_id missing" do
    comment = Comment.create(@params.except(:user_id))
    assert_not comment.valid?
  end
  
  test "can not create a Comment if post_id missing" do
    comment = Comment.create(@params.except(:post_id))
    assert_not comment.valid?
  end
  
  test "can not create a Comment if body missing" do
    comment = Comment.create(@params.except(:body))
    assert_not comment.valid?
  end
end
