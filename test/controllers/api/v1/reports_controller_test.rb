require 'test_helper'

class Api::V1::ReportsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get api_v1_state_reports_url(states(:co))
    assert_response :success
  end

  test 'should get index as json' do
    get api_v1_state_reports_url(states(:co))
    data = JSON.parse(@response.body)
    assert data['reports'].count == 2
  end

  test 'should get paginated index' do
    get api_v1_state_reports_url(states(:co), page: 2, per_page: 1)
    data = JSON.parse(@response.body)
    assert data['reports'][0]['date'] == 1
  end

  test 'should return error on invalid state' do
    get api_v1_state_reports_url(state_id: 'ia')
    assert_response :missing
  end
end
