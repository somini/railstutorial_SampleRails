require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:somini)
    @user1 = users(:mhartl)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to accounts_login_url
  end
  test "should redirect edit when logged in as wrong user" do
    login_as(@user)
    get :edit, id: @user1
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @user, user: {nick: @user.nick , mail: @user.mail}
    assert_not flash.empty?
    assert_redirected_to accounts_login_url
  end

  test "should redirect update when logged in as wrong user" do
    login_as(@user)
    patch :update, id: @user1, user: {nick: @user.nick , mail: @user.mail}
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to accounts_login_url
  end

end
