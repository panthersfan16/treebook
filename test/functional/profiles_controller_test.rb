require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, id: users(:frank).profile_name
    assert_response :success
    assert_template 'profiles/show'
  end

  test "should get a 404 page for a profile that doesn't exist" do
  	get :show, id: "doesn't exist"
  	assert_response :not_found 
  end

  test "that variables are assigned on successful profile viewing" do
    get :show, id: users(:frank).profile_name
    assert assigns(:user)
    assert_not_empty assigns(:statuses)
  end
  
  test "only the correct statuses are shown on a user's profile page" do
  	get :show, id: users(:frank).profile_name
  	assigns(:statuses).each do |status|
  		assert_equal users(:frank), status.user
  	end
  end

end
