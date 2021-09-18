require "test_helper"

class UserTest < ActiveSupport::TestCase

  #MANDATORY: email, name, birth_date, encrypted password
  #OPTIONAL: provider, uid, gender. (right now no way to create user without a gender. )

  test "doesn't save blank user" do
    user = User.new
    assert_not user.save, "Saved blank user"
  end

  test "fails if age is below 13 years old" do
    user = users(:one)
    user.birth_date = "21-04-2021"
    assert_not user.save, "Saved invalid birthdate"
  end

  test "fails if age is above 120 years old" do
    user = users(:one)
    user.birth_date = "21-04-1860"
    assert_not user.save, "Saved invalid birthdate"
  end

  # test "fails if gender is blank" do 
  #   user = users(:one)
  #   user.gender = nil
  #   assert_not user.save, "Save blank gender"
  # end

  test "saves a valid user" do 
    assert users(:one).save, "Didn't save valid user"
  end

end
