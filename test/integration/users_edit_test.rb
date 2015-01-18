require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:somini)
  end

  test 'Invalid edit' do
    login_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: {
	    nick: "",
	    mail: "invalid@domain",
	    password: "ha",
	    password_confirmation: "haha"
    }
    assert_template 'users/edit'
  end

  test 'Valid edit (No Password), not logged in yet' do
    get edit_user_path(@user)
    login_as(@user)
    assert_redirected_to edit_user_path(@user)
    data = { nick: "A Name",
             mail: "some@email.address",
	     password: "",
	     password_confirmation: ""
    }
    patch user_path(@user), user: data
    assert_not flash.empty?
    assert_redirected_to @user
    # Check is the user was updated in the DB
    @user.reload
    assert_equal @user.nick, data[:nick]
    assert_equal @user.mail, data[:mail]
  end
end
