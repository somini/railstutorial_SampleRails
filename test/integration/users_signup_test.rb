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
  end

end
