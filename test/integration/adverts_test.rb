require 'test_helper'

class AdvertsTest < ActionDispatch::IntegrationTest
  test "advert index show all adverts" do
    visit adverts_path
    within "body" do
      assert_equal all('.well').count, Advert.all.count
    end
  end

  test "delete and edit buttons can see only advert owner" do
    visit adverts_path
    assert !page.has_selector?(".btn-group")
    login_as(users(:dimon), scope: :user)
    visit adverts_path
    assert_equal all(".btn-group").count, users(:dimon).adverts.count
  end

  test "advert show page has all adverts comments" do
    visit advert_path(adverts(:dimon_advert))
    assert_equal all(".comment").count, adverts(:dimon_advert).comments.count
  end

  test "comment ajax delete button work" do
    login_as(users(:dimon), scope: :user)
    visit advert_path(adverts(:dimon_advert))
    within "#comment-#{adverts(:dimon_advert).comments.first.id}" do
      before_click = adverts(:dimon_advert).comments.count
      click_on("Delete")
      assert_equal adverts(:dimon_advert).comments.count, before_click - 1
    end
  end

  test "comment ajax edit button work" do
    
  end
end
