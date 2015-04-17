require 'test_helper'

class AdvertsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @update = {
        title: "Test",
        description: "Hello world.",
        image: "hello.jpg"
      }
    @advert = adverts(:dimon_advert)
    @user = users(:dimon)
    @user.role = roles(:generic)
    @user.save
    sign_in @user
  end

  test "get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:adverts)
  end

  test "get new" do
    get :new
    assert_response :success
  end

  test "create advert" do
    assert_difference('Advert.count') do
      post :create, advert: @update
    end

    assert_redirected_to advert_path(assigns(:advert))
  end

  test "get show advert" do
    get :show, id: @advert
    assert_response :success
  end

  test "get edit advert" do
    get :edit, id: @advert
    assert_response :success
  end

  test "update advert" do
    patch :update, id: @advert, advert: @update
    assert_redirected_to advert_path(assigns(:advert))
  end

  test "destroy advert" do
    assert_difference('Advert.count', -1) do
      delete :destroy, id: @advert
    end

    assert_redirected_to adverts_path
  end

end
