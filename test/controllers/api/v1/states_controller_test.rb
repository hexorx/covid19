require 'test_helper'

class Api::V1::StatesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get api_v1_states_url
    assert_response :success
  end

  test 'should get index as json' do
    get api_v1_states_url
    data = JSON.parse(@response.body)
    assert data['states'].count == 2
  end

  test 'should get paginated index' do
    get api_v1_states_url(page: 2, per_page: 1)
    data = JSON.parse(@response.body)
    assert data['states'][0]['id'] == 'hi'
  end

  test 'should get details' do
    get api_v1_state_url(states(:co))
    assert_response :success
  end

  test 'should return error on invalid state' do
    get api_v1_state_url(id: 'ia')
    assert_response :missing
  end
end
