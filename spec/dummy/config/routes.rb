Rails.application.routes.draw do
  get 'simple_search' => 'search#simple_search'
  get 'controller_sanitized_simple_search' => 'search#controller_sanitized_simple_search'
  get 'method_sanitized_simple_search' => 'search#method_sanitized_simple_search'
  get 'raw_range_search' => 'search#raw_range_search'
  get 'range_search' => 'search#range_search'
  get 'full_search' => 'search#full_search'
end
