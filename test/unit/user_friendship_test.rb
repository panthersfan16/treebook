require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)

    test "that creating a friendship works without raising an exception" do
  	 assert_nothing_raised do
      UserFriendship.create user: users(:frank), friend: users(:mike)
     end
   end

   test "that creating a user friendship based on user_id and friend_id works" do
   	UserFriendship.create user_id: users(:frank).id, friend_id: users(:mike).id
   	assert users(:frank).friends.include?(users(:mike))
   end
end
