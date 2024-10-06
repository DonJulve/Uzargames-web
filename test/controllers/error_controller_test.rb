require "test_helper"

class ErrorControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'render error 404' do
    get '/error'

    assert_response :not_found
  end


  test 'render error 403' do
    get '/admin'

    assert_response :redirect
    assert_redirected_to('/error')

    follow_redirect!

    assert_response :forbidden

  end

end
