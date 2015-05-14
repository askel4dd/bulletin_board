require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @dimon = users(:dimon)
    @dimon.save
    @ability = Ability.new(@dimon)
    @not_registered = User.new
    @not_registered_ability = Ability.new(@not_registered)
    @moderator = User.new
    @moderator.role = roles(:moderator)
    @moderator_ability = Ability.new(@moderator)
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
    assert @not_registered_ability.can?(:create, User)
  end

  test "not registered user cannot edit users" do
    assert @not_registered_ability.cannot?(:edit, User)
  end

  test "not registered user cannot create adverts" do
    assert @not_registered_ability.cannot?(:create, Advert)
  end

  test "not registered user cannot create comments" do
    assert @not_registered_ability.cannot?(:create, Comment)
  end

  test "not registered user cannot edit adverts" do
    assert @not_registered_ability.cannot?(:edit, Advert)
  end

  test "not registered user cannot edit comments" do
    assert @not_registered_ability.cannot?(:edit, Comment)
  end

  test "not registered user can read users" do
    assert @not_registered_ability.can?(:read, User)
  end

  test "not registered user can read adverts" do
    assert @not_registered_ability.can?(:read, Advert)
  end

  test "not registered user can read comments" do
    assert @not_registered_ability.can(:read, Comment)
  end

  test "generic user can create adverts" do
    assert @ability.can(:create, Advert)
  end

  test "generic user can create comments" do
    assert @ability.can(:create, Comment)
  end

  test "generic user can manage himself" do
    assert @ability.can(:manage, @dimon)
  end

  test "generic user can read users" do
    assert @ability.can(:read, User)
  end

  test "generic user can read adverts" do
    assert @ability.can(:read, Advert)
  end

  test "generic user can read comments" do
    assert @ability.can(:read, Comment)
  end

  test "moderator user can manage adverts" do
    assert @moderator_ability.can(:manage, Advert)
  end

  test "moderator user can manage comments" do
    assert @moderator_ability.can(:manage, Comment)
  end

  test "moderator can manage only himself" do
    assert @moderator_ability.can(:manage, @moderator)
    assert @moderator_ability.cannot(:manage, User)
  end

  test "admin user can manage all" do
    admin = User.new
    admin.role = roles(:admin)
    admin_ability = Ability.new(admin)
    assert admin_ability.can(:manage, :all)
  end
end
