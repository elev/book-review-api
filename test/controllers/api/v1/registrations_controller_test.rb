require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test 'should register user' do
    post api_v1_sign_up_path(
      params: { 
        user: { 
          email: 'test@foo.com',
          password: 'foobar',
          password_confirmation: 'foobar'
        }
      }
    )
    assert_response :success
  end

  test 'should throw error with bad password' do
    post api_v1_sign_up_path(
      params: { 
        user: { 
          email: 'test@foo.com',
          password: 'foobar',
          password_confirmation: 'foobardiff'
        }
      }
    )
    assert_response :unprocessable_entity
  end

  test 'should throw error with bad params' do
    post api_v1_sign_up_path(
      params: {}
    )
    assert_response :bad_request
  end
end