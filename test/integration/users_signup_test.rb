require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "user signup should reject invalid data" do
    get accounts_signup_path
    assert_no_difference 'User.count' do
      post users_path, user:{
        nick:"a nick",mail:"me@invalid",
        password:"",password_confirmation:"a"
      }
    end
    assert_template 'users/new'
    # Should have some errors
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "correct user signup" do
    get accounts_signup_path
    assert_difference 'User.count', +1 do
      post_via_redirect users_path, user:{
        nick:"test",mail:"test@test.tld",
        password:"xfdcgvhbjxfdcgvhbj",password_confirmation:"xfdcgvhbjxfdcgvhbj"
      }
    end
    assert_template 'users/show'
    # Should have flash sucess ...
    assert_not flash.empty?
    assert is_logged_in?
    # After being logged in
    ### No Log in option
    assert_select "a[href=?]", accounts_login_path, count: 0
    ### One logout and one for your profile
    assert_select "a[href=?]", accounts_logout_path
    # ... and then goes away when you reload the page
    reload_page
    assert flash.empty?
    assert is_logged_in?
  end

end
