require "test_helper"

class BuscadorControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'search with no results' do
    get '/buscador'

    assert_response :success

    if css_select('.NOTICIA').size == 0
      assert_select '#NO_RESULTS', 1
    else
      assert_select '#NO_RESULTS', 0
    end
    
  end

end
