require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contacts_path

    assert_select "a[href=?]", accounts_signup_path
  end

  test "titles" do
    get accounts_signup_path
    assert_select "title", full_title("Sign Up")
  end

end
