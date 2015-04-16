require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @user = users(:dimon)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end
end
