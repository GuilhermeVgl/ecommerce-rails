require "test_helper"

class Admin::ExtrasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_extra = admin_extras(:one)
  end

  test "should get index" do
    get admin_extras_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_extra_url
    assert_response :success
  end

  test "should create admin_extra" do
    assert_difference("Admin::Extra.count") do
      post admin_extras_url, params: { admin_extra: { name: @admin_extra.name, price: @admin_extra.price } }
    end

    assert_redirected_to admin_extra_url(Admin::Extra.last)
  end

  test "should show admin_extra" do
    get admin_extra_url(@admin_extra)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_extra_url(@admin_extra)
    assert_response :success
  end

  test "should update admin_extra" do
    patch admin_extra_url(@admin_extra), params: { admin_extra: { name: @admin_extra.name, price: @admin_extra.price } }
    assert_redirected_to admin_extra_url(@admin_extra)
  end

  test "should destroy admin_extra" do
    assert_difference("Admin::Extra.count", -1) do
      delete admin_extra_url(@admin_extra)
    end

    assert_redirected_to admin_extras_url
  end
end
