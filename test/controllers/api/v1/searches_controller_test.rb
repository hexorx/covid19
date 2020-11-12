require 'test_helper'

class Api::V1::SearchesControllerTest < ActionDispatch::IntegrationTest
  test 'valid search create' do
    post api_v1_searches_url, params: { start: 1, end: 1 }
    assert_response :success
  end

  test 'invalid search create' do
    post api_v1_searches_url, params: { start: 2, end: 1 }
    assert_response :unprocessable_entity
  end

  test 'search results' do
    get api_v1_search_url(searches(:two)), params: { start: 2, end: 1 }
    data = JSON.parse(@response.body)
    assert data['results'][0]['state_id'] == 'hi'
    assert data['results'][0]['min_cases'] == 1
    assert data['results'][0]['max_cases'] == 1
    assert data['results'][0]['change_in_cases'] == 0
  end
end
