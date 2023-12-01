require_relative "test_helper"

class PretenderTest < ActionDispatch::IntegrationTest
  def setup
    User.delete_all
    AdminUser.delete_all
  end

  def test_works
    admin = User.create!(name: "Admin")
    user = User.create!(name: "User")

    get root_url
    assert_response :success

    assert_equal admin, current_user
    assert_equal admin, true_user

    post impersonate_url
    assert_response :success

    assert_equal user, current_user
    assert_equal admin, true_user

    post stop_impersonating_url
    assert_response :success

    assert_equal admin, current_user
    assert_equal admin, true_user
  end

  def test_works_with_multiple_models
    admin = AdminUser.create!(name: "Admin")
    user = User.create!(name: "User")

    get page_url
    assert_response :success

    assert_equal nil, current_user
    assert_equal admin, current_admin_user
    assert_equal admin, true_admin_user

    post page_impersonate_url
    assert_response :success

    assert_equal user, current_user
    assert_equal admin, current_admin_user
    assert_equal admin, true_admin_user

    post page_stop_impersonating_url
    assert_response :success

    assert_equal nil, current_user
    assert_equal admin, current_admin_user
    assert_equal admin, true_admin_user
  end

  private

  def current_user
    controller.current_user
  end

  def true_user
    controller.true_user
  end

  def current_admin_user
    controller.current_admin_user
  end

  def true_admin_user
    controller.true_admin_user
  end
end
