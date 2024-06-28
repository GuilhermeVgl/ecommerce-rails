require "application_system_test_case"

class Admin::ExtrasTest < ApplicationSystemTestCase
  setup do
    @admin_extra = admin_extras(:one)
  end

  test "visiting the index" do
    visit admin_extras_url
    assert_selector "h1", text: "Extras"
  end

  test "should create extra" do
    visit admin_extras_url
    click_on "New extra"

    fill_in "Name", with: @admin_extra.name
    fill_in "Price", with: @admin_extra.price
    click_on "Create Extra"

    assert_text "Extra was successfully created"
    click_on "Back"
  end

  test "should update Extra" do
    visit admin_extra_url(@admin_extra)
    click_on "Edit this extra", match: :first

    fill_in "Name", with: @admin_extra.name
    fill_in "Price", with: @admin_extra.price
    click_on "Update Extra"

    assert_text "Extra was successfully updated"
    click_on "Back"
  end

  test "should destroy Extra" do
    visit admin_extra_url(@admin_extra)
    click_on "Destroy this extra", match: :first

    assert_text "Extra was successfully destroyed"
  end
end
