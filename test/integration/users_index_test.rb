require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:somini)
  end

  test "index includes pagination" do
    login_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    User.paginate(page:1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.nick
    end
  end
end
