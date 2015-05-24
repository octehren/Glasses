require 'spec_helper'
#tests in a raw environment with a hash serving as input (the default ruby web app frameworks "params" hash is the emulated input)
require 'tests/search_test'
require 'tests/sanitized_search_test'

#tests in a simulated webpage environment using Capybara
require 'features/simple_search_form_test'