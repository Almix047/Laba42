require 'test_helper'

# :reek:IrresponsibleModule
class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get home_index_url
    assert_response :success
  end
end
