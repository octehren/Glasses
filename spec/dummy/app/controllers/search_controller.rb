class SearchController < ApplicationController

	before_action(only: [:sanitized_simple_search]) do |c| 
		c.search_params_sanitizer_defined_in_the_app(params[:action]) # parameters passed in the controller action
	end

	def simple_search
		if params[:search_params]
			@players = Glasses.search(Player, params[:search_params])
			@num_results = 0
		else
			@players = []
		end
	end

	def sanitized_simple_search
		if params[:sanitized_search_params]
			@players = Glasses.search(Player, params[:search_params])
			@num_results = 0
		else
			@players = []
		end
	end

	def method_sanitized_simple_search
		if params[:sanitized_search_params]
			@players = Glasses.sanitized_search(Player, params[:search_params])
			@num_results = 0
		else
			@players = []
		end
	end

end
