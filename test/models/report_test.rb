require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'valid report' do
    state = Report.new(state: states(:co), date: 3)
    assert state.valid?
  end

  test 'valid report for unique date by state' do
    state = Report.new(state: states(:hi), date: 2)
    assert state.valid?
  end

  test 'invalid report without state' do
    report = Report.new(date: 3)
    refute report.valid?, 'report is valid without a state'
    assert_not_nil report.errors[:state], 'no validation error for state present'
  end

  test 'invalid report without date' do
    report = Report.new(state: states(:co))
    refute report.valid?, 'report is valid without a date'
    assert_not_nil report.errors[:date], 'no validation error for date present'
  end

  test 'invalid report without unique date scoped by state' do
    report = Report.new(state: states(:co), date: 2)
    refute report.valid?, 'report is valid without unique a date'
    assert_not_nil report.errors[:date], 'no validation error for date present'
  end
end
