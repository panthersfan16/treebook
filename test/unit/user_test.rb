require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should have_many (:user_friendships)
  should have_many (:friends)

  test "a user should enter a first name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:first_name].empty?
  end

  test "a user should enter a last name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:last_name].empty?
  end

  test "a user should enter a profile name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a unique profile name" do
  	user = User.new
  	user.profile_name = users(:frank).profile_name
  	
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile name without spaces" do
    user = User.new(first_name: 'Frank', last_name: 'Mesa', email: 'ishotuagain@yahoo.com')
    user.password = user.password_confirmation = 'treebook'
    user.profile_name = "My Profile With Spaces"

    assert !user.save
    assert !user.errors[:profile_name].empty?
    assert user.errors[:profile_name].include?("Must be formatted correctly.")
  end

  test "a user can have a correctly formated profile name" do
    user = User.new(first_name: 'Franky', last_name: 'Mesa2', email: 'panthersfan19@hotmail.com')
    user.password = user.password_confirmation = 'treebook'

    user.profile_name = 'frankmesa0'
    assert user.valid?
  end

  test "no error is raised when trying to access a friend list" do
    assert_nothing_raised do
      users(:frank).friends
    end
  end

  test "that creating friendships on a user works" do
    users(:frank).friends << users(:mike)
    users(:frank).friends.reload
    assert users(:frank).friends.include?(users(:mike))
  end
end

