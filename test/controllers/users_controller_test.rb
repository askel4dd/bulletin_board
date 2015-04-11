require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @user = users(:dimon)
  end

  test "should get index" do
    get :index
    assert_response :success
  end
end
