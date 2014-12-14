ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'

Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include ApplicationHelper

  def reload_page
    get @request.original_url
  end

  def is_logged_in?
    !session[:user_id].nil?
  end

  def login_as(user, options = {})
    password = options[:password] || 'swordfish'
    remember_me = options[:remember_me] ? '1' : '0'
    if integration_test?
      post accounts_login_path, session: {
        nick: user.nick,
        password: password,
        remember_me: remember_me
      }
    else
      session[:user_id] = user.id
    end
  end

  private
    def integration_test?
      # Hack-ish
      return defined?(post_via_redirect)
    end
end
