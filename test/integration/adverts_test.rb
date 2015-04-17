require 'test_helper'

class AdvertsTest < ActionDispatch::IntegrationTest

  def setup
    @dimon = users(:dimon)
    @dimon.role = roles(:generic)
    @dimon_advert = adverts(:dimon_advert)
    @comment = @dimon_advert.comments.first
  end

  test "advert index show all adverts" do
    visit adverts_path
    within "body" do
      assert_equal all('.well').count, Advert.all.count
    end
  end

  test "delete and edit on advert index buttons can see only advert owner" do
    login_as(@dimon, scope: :user)
    visit adverts_path
    assert_equal all(".btn-group").count, users(:dimon).adverts.count
  end

  test "advert show page has all adverts comments" do
    visit advert_path(@dimon_advert)
    assert_equal all(".comment").count, @dimon_advert.comments.count
  end

  test "comment body text show after ajax success" do
    login_as(@dimon, scope: :user)
    visit advert_path(@dimon_advert)
    within "#comment-#{@comment.id}" do
      find("#edit-comment-#{@comment.id}").click
      find(".form_in_place")
      page.execute_script <<-JS
        $("#best_in_place_comment_#{@comment.id}_body form textarea").val("Edited text");
        $("#best_in_place_comment_#{@comment.id}_body form").submit();
      JS
    end
    assert page.has_content?("Edited text")
  end

 # test "comment ajax delete button work" do
 #   login_as(users(:dimon), scope: :user)
 #   visit advert_path(@dimon_advert)
 #   within "#comment-#{@comment_to_delete.id}" do
 #     before_click = @dimon_advert.comments.count
 #     click_on("Delete")
 #     wait_for_ajax
 #     assert_equal @dimon_advert.comments.count, before_click - 1
 #   end
 # end

end
