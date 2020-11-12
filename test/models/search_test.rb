require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  test 'valid search' do
    search = Search.new(start: 2, end: 3)
    assert search.valid?
  end

  test 'invalid search without start' do
    search = Search.new(end: 3)
    refute search.valid?, 'search is valid without a start'
    assert_not_nil search.errors[:start], 'no validation error for start present'
  end

  test 'invalid search without end' do
    search = Search.new(start: 3)
    refute search.valid?, 'search is valid without an end'
    assert_not_nil search.errors[:end], 'no validation error for end present'
  end

  test 'invalid dublicate search' do
    search = Search.new(start: 1, end: 2)
    refute search.valid?, 'search is valid without being unique'
    assert_not_nil search.errors[:end], 'no validation error for end present'
  end

  test 'invalid search with end before start' do
    search = Search.new(start: 3, end: 2)
    refute search.valid?, 'search is valid with end before start'
    assert_not_nil search.errors[:end], 'no validation error for end present'
  end

  test 'should return aggregate results grouped by state' do
    search = Search.new(start: 1, end: 2)
    results = search.results
    assert results.count == 2
  end
end
