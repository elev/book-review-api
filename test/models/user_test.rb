require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'User Creation' do
    user = User.new(
      email: 'jones@foo.com', 
      password: Devise::Encryptor.digest(User, 'p@55w0rd')
    )
    assert user.valid?
  end
end
