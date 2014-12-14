require 'test_helper'

class UsersSessionTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:somini)
  end

  test "invalid login - empty" do
    get accounts_login_path
    assert_template 'sessions/new'
    post accounts_login_path, session: {nick:"", password:""}
    assert_template 'sessions/new' # No redirects so far
    assert_not flash.empty?, "Flash doesn't get set"
    get root_path
    assert flash.empty?, "Flash persists between requestss"
  end

  test "valid login and logout" do
    get accounts_login_path
    assert_template 'sessions/new'
    post accounts_login_path, session: { nick: @user.nick, password: 'swordfish' }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    # After being logged in
    ### No Log in option
    assert_select "a[href=?]", accounts_login_path, count: 0 
    ### One logout and one for your profile
    assert_select "a[href=?]", accounts_logout_path
    assert_select "a[href=?]", user_path(@user)

    # Logout
    delete accounts_logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
    delete accounts_logout_path # Logout on logged out users is a no-op
    follow_redirect!
    # After being logged out
    ### Log in option
    assert_select "a[href=?]", accounts_login_path
    ### No logout nor for your profile
    assert_select "a[href=?]", accounts_logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

end
