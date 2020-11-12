require 'test_helper'

class StateTest < ActiveSupport::TestCase
  test 'valid state' do
    state = State.new(code: 'ia', name: 'Iowa')
    assert state.valid?
  end

  test 'invalid state without code' do
    state = State.new(name: 'Iowa')
    refute state.valid?, 'state is valid without a code'
    assert_not_nil state.errors[:code], 'no validation error for code present'
  end

  test 'invalid state without name' do
    state = State.new(code: 'ia')
    refute state.valid?, 'state is valid without a name'
    assert_not_nil state.errors[:name], 'no validation error for name present'
  end

  test 'invalid state without unique code' do
    state = State.new(code: 'co', name: 'Colorado')
    refute state.valid?, 'state is valid with a duplicate code'
    assert_not_nil state.errors[:code], 'no validation error for code present'
  end

  test 'invalid state without unique name' do
    state = State.new(code: 'co', name: 'Colorado')
    refute state.valid?, 'state is valid with a duplicate name'
    assert_not_nil state.errors[:name], 'no validation error for name present'
  end

  test 'invalid state without lower case code' do
    state = State.new(code: 'Ia', name: 'Iowa')
    refute state.valid?, 'state is valid with an invalid code'
    assert_not_nil state.errors[:code], 'no validation error for code present'
  end

  test 'invalid state without more than 2 character code' do
    state = State.new(code: 'iaa', name: 'Iowa')
    refute state.valid?, 'state is valid with an invalid code'
    assert_not_nil state.errors[:code], 'no validation error for code present'
  end
end
