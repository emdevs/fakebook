require "test_helper"

class PostTest < ActiveSupport::TestCase
  #each post MUST have title, body, user and postable. 
  #attached image, comments and likes optional. 

  # test "fails if post is blank" do
  #   post = Post.new
  #   assert_not post.save, "Saved blank post"
  # end

  # test "fails if post title is less than 5 characters" do
  #   post = posts(:one)
  #   post.title = "less"
  #   assert_not post.save, "Saved invalid post title"
  # end

  # test "fails if post body is less than 10 characters" do
  #   post = posts(:one)
  #   post.body = "less"
  #   assert_not post.save, "Saved invalid post body"
  # end

  # test "fails if post doesn't belong to a user" do
  #   post = posts(:one)
  #   post.user = nil
  #   assert_not post.save, "Saved with nil user"
  # end

  # test "fails if post doesn't belong to a postable" do
  #   post = posts(:one)
  #   post.postable = nil
  #   assert_not post.save, "Saved with nil postable"
  # end


  # #is it ebcause user and wall doesn't exist yet?
  # test "passes with valid post" do
  #   #why is this failing?
  #   newpost = Post.new(
  #     title: "MyString",
  #     body: "MyText that is long enough for body",
  #     user_id: 1,
  #     postable_id: 1,
  #     postable_type: "Wall",
  #   )
  #   puts User.first
  #   # assert posts(:one).save, "Didn't save valid post."
  #   assert newpost.save, "didnt save valid post"
  # end
end
