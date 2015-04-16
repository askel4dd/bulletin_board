require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @dimon = users(:dimon)
    @dimon.save
    @ability = Ability.new(@dimon)
  end

  test "full_address return proper string" do
    assert_equal "#{@dimon.zip}, #{@dimon.address}, #{@dimon.city}, #{@dimon.state}, #{@dimon.country}",
                  @dimon.full_address
  end

  test "user role set to generic after creation" do
    assert_equal @dimon.role.name, "Generic"
  end

  test "role? method return false if user role is nor set" do
    @dimon.role = nil
    assert !@dimon.role?(:generic)
  end

  test "role? method return false if user role not equal to func input" do
    assert !@dimon.role?(:moderator)
  end

  test "role? method return true if user role equal to func input" do
    assert @dimon.role?(:generic)
  end

  test "user latitude and longitude geocoded after validation" do
    assert @dimon.latitude
    assert @dimon.longitude
  end

  test "user can only destroy advert which they own" do
    assert @ability.can?(:destroy, adverts(:dimon_advert))
    assert @ability.cannot?(:destroy, adverts(:frank_advert))
  end

  test "user can only destroy comment which they own" do
    assert @ability.can?(:destroy, comments(:dimon_comment))
    assert @ability.cannot?(:destroy, comments(:frank_comment))
  end

  test "user can only edit advert which they own" do
    assert @ability.can?(:edit, adverts(:dimon_advert))
    assert @ability.cannot?(:edit, adverts(:frank_advert))
  end

  test "user can only edit comment which they own" do
    assert @ability.can?(:edit, comments(:dimon_comment))
    assert @ability.cannot?(:edit, comments(:frank_comment))
  end

  test "not registered user can create new user" do

  end
end
