require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test 'should get books' do
    get api_v1_books_path
    parsed_response = JSON.parse(response.body)
    
    assert_response :success
    assert(parsed_response['data']['books'].length == 2)
  end

  test 'should get 1 book by id' do
    get api_v1_book_path(id: 1)
    parsed_response = JSON.parse(response.body)
    
    assert_response :success
    assert(parsed_response['data']['book']['title'] == 'Fangs of shangri la')
  end
end