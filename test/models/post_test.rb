require 'test_helper'

class PostTest < ActiveSupport::TestCase
  setup do
    @params = { title: "Test Post",
               body: "Test post body"
    }
  end

  test "can create a Post" do
    post = Post.create(@params)
    assert post.valid?
  end

  test "can not create a Post if title missing" do
    post = Post.create(@params.except(:title))
    assert_not post.valid?
  end
  
  test "can not create a Post if body missing" do
    post = Post.create(@params.except(:body))
    assert_not post.valid?
  end
end
