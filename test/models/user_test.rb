require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(nick: "somini", mail:"a@b.c",
      password: "fooooooooobar", password_confirmation:"fooooooooobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "nick should exist" do
    @user.nick = " 	"
    assert_not @user.valid?
  end

  test "mail should exist" do
    @user.mail = "	"
    assert_not @user.valid?
  end

  test "nick should be short" do
    @user.nick = "C" * 101
    assert_not @user.valid?
  end

  test "mail should be not too long" do
    @user.mail = "u" * 257
    assert_not @user.valid?
  end


  test "mail should be a valid email address" do
    valid_addresses = %w[as@saf.ca MAN@SERVER.TLD person@coisa.pt]
    valid_addresses.each do |email|
      @user.mail = email
      assert @user.valid?, "#{email} should be valid"
    end
  end
  test "mail shouldn't be an invalid email address" do
    invalid_addresses = %w[as@saf,ca MAN@SERVER:TLD person_AT_coisa.pt a@b..com b@..com]
    invalid_addresses.each do |email|
      @user.mail = email
      assert_not @user.valid?, "#{email} shouldn't be valid"
    end
  end
  test "mail should be case insensitive" do
    email = "fooObBa@gOOgLe.CoM"
    @user.mail = email
    @user.save
    @user.reload
    assert_equal @user.mail, email.downcase
  end

  test "nicks should be unique" do
    h=@user.dup
    h.mail = "b@c.d"
    @user.save
    assert_not h.valid?
  end
  test "nicks should be case-sensitive" do
    diff=@user.dup
    diff.nick.upcase!
    @user.save
    assert diff.valid?
  end

  test "password should be strong" do
    @user.password = @user.password_confirmation = "b" * 9
    assert_not @user.valid?
  end
end
