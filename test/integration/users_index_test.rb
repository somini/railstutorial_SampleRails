require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:somini)
    @user_non_admin = users(:mhartl)
    @paginate_per_page = 10
  end

  test "index includes pagination" do
    login_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    User.paginate(page:1, per_page:@paginate_per_page).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.nick
    end
  end

  test "index as admin" do
    login_as(@user)
    get users_path
    User.paginate(page:1,per_page:@paginate_per_page).each do |user|
      unless user == @user
	assert_select 'a[href=?]', user_path(user), method: :delete
      end
    end

    assert_difference 'User.count', -1 do
      delete user_path(@user_non_admin)
    end
  end

  test "index as non-admin" do
    login_as(@user_non_admin)
    get users_path
    assert_select 'a', text: "delete", count: 0
  end
end
