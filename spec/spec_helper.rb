# frozen_string_literal: true

if ENV['SIMPLECOV'] == '1'
  require 'coveralls'
  require 'simplecov'

  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
  SimpleCov.start do
    add_filter '/.bundle/'
    add_filter '/doc/'
    add_filter '/spec/'
    add_filter '/config/'
    merge_timeout 600
  end
end

require 'minitest/autorun'

$:.unshift File.expand_path('../../lib', __FILE__)
require 'user_agent_parser'

module MiniTest
  module Assertions
    # Asserts the test case property is equal to the expected value. On failure
    # the message includes the property and user_agent_string from the test
    # case for easier debugging
    def assert_test_case_property_equal(test_case, actual, test_case_property)
      assert_equal test_case[test_case_property],
                   actual,
                   "#{test_case_property} failed for user agent: #{test_case['user_agent_string']}"
    end

    Object.infect_an_assertion :assert_test_case_property_equal, :must_equal_test_case_property
  end
end
