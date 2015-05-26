class SearchController < ApplicationController

	#before_action(only: [:controller_sanitized_simple_search]) do |c| 
	#	c.search_params_sanitizer_defined_in_the_app(params[:action]) # parameters passed in the controller action
	#end
	#before_action(:search_params_sanitizer_defined_in_the_app, only: [:controller_sanitized_simple_search])

	def simple_search
		if params[:search_params]
			@players = Glasses.search(Player, params[:search_params])
			@num_results = 0
		else
			@players = []
		end
	end

	def method_sanitized_simple_search
		if params[:search_params]
			@players = Glasses.sanitized_search(Player, params[:search_params])
			@num_results = 0
		else
			@players = []
		end
	end

	def controller_sanitized_simple_search
		if params[:search_params]
			sanitized_params = search_params_sanitizer_defined_in_the_app(params[:search_params])
			@players = Glasses.search(Player, sanitized_params)
			@test_params = sanitized_params
			@num_results = 0
		else
			@players = []
		end
	end

	protected

	def search_params_sanitizer_defined_in_the_app(search_params, escape_char = "\\")
	  sanitized_params = {}
	  pattern = Regexp.union(escape_char, "%", "_", "--", "=")
	  search_params.each do |key, val| 
	  	#sanitized_params[key] = ActiveRecord::Base.sanitize(val)
	  	#sanitized_params[key] = val
	  	sanitized_params[key] = val.gsub(pattern) do |s| 
	  		[escape_char, s].join
	  	end
	  end
	  return sanitized_params
  	end

end
