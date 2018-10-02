require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should sign in user' do
    post api_v1_sign_in_path(
      params: {
        sign_in: {
          email: 'john@john.com',
          password: 'p@55w0rd'
        }
      }
    )
    assert_response :success
  end

  test 'bad password should prevent login' do
    post api_v1_sign_in_path(
      params: {
        sign_in: {
          email: 'john@john.com',
          password: 'the wrong password'
        }
      }
    )
    assert_response :unauthorized
  end

  test 'bad email should prevent login' do
    post api_v1_sign_in_path(
      params: {
        sign_in: {
          email: 'doesnotexist@john.com',
          password: 'p@55w0rd'
        }
      }
    )
    assert_response :unauthorized
  end

  test 'should logout' do
    delete api_v1_log_out_path, headers: {'AUTH-TOKEN' => '123-456'}
    assert_response :ok
  end

  test 'should not logout with bad token' do
    delete api_v1_log_out_path, headers: {'AUTH-TOKEN' => 'incorrect token'}
    assert_response :network_authentication_required
  end
end